# HPL-prediction-of-response-to-ICI-in-Melanoma

Use of the Histomorphological Phenotype Learning self-supervised tools to study the response to ICI in Melanoma. This repository is related to the manuscriot titled: "Artificial Intelligence Algorithm Predicts Response to Immune Checkpoint Inhibitors." It is provided as is for research purpose and must not be use in clinical practice.

## Associated manuscript

[Fa'ak F, Coudray N, Jour G, Ibrahim M, Illa-Bochaca I, Qiu S, Claudio Quiros A, Yuan K, Johnson DB, Rimm DL, Weber JS. Artificial Intelligence Algorithm Predicts Response to Immune Checkpoint Inhibitors. Clinical Cancer Research. 2025 Jun 24.](https://aacrjournals.org/clincancerres/article/doi/10.1158/1078-0432.CCR-24-3720/763552/Artificial-Intelligence-Algorithm-Predicts)

## Required packages
To run the code you need to install [DeepPATH](https://github.com/ncoudray/DeepPATH) and [HPL](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). 
Both pages include detailed description on the libraries to install as well as the meaning of the options used here.

The code here was developed using the slurm executor on NYU's [UltraViolet HPC cluster](https://med.nyu.edu/research/scientific-cores-shared-resources/high-performance-computing-core). The python script is therefore here given with slurm headers appropriate for this cluster as example so they could easily be adapted.  

The steps below detail the code used in the manuscript, from training Barlow-Twins to Cox regressions, including the leiden clustering step. The checkpoints of the trained networks can be downloaded from our [public repository](https://genome.med.nyu.edu/public/tsirigoslab/DeepLearning/Melanoma_Faak_etal/). To project your own dataset into the trained Barlow-Twins network and associate the HPCs, see the README file in the `case_study` folder


## 1. Pre-processing

These steps rely on the commands from [DeepPATH](https://github.com/ncoudray/DeepPATH). See the original github page for explanations regarding the meaning of the options used here. 


Images first need to be tiled and converted to H5. For each datasets, the following commands from DeepPATH was used:

**1.a. Tiling:**
```shell
python DeepPATH_code/00_preprocessing/0b_tileLoop_deepzoom6.py  -s 896 -e 0  -j 20 -B 40 -M 40 -D 16   -o "896px_40x_B40_Cohort_1" -N '57,22,-8,20,10,5' /path_to_slides_from_cohort1/*svs
```

**1.b. Combine all tiles** 
```shell
python DeepPATH_code/00_preprocessing/0d_SortTiles.py --SourceFolder='896px_40x_B40_Cohort_1' --Magnification=40  --MagDiffAllowed=0 --SortingOption=10 --PatientID=10 --nSplit 0 --Balance=2  --PercentValid=25 --PercentTest=25
```

These needs to be run for all the cohorts used to train HPL (called cohortsA in the next step; in the manuscript, composed of datasets from Vanderbilt, Yale and the two Checkmates datasets) - Note, that cohort is itself split into a train, validation and test set.

For the additional test set (named cohortB here, and corresponding to the dataset from NYU in the manuscript), the same command with `--PercentValid=0 --PercentTest=100` is used instead. The outputs from the train cohorts must be saved (or symlinked) in a single empty folder before conversion to h5. The test set must be in its own sub-folder too. 


**1.c. Convert to h5 files:**

The cohorts used to train HPL are converted to H
```shell
mpirun -n 40 python DeepPATH_code/00_preprocessing/0e_jpgtoHDF.py  --input_path path_to_output_of_previous_step  --output hdf5_cohortsA_he_train.h5   --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='train'

mpirun -n 40 python DeepPATH_code/00_preprocessing/0e_jpgtoHDF.py  --input_path path_to_output_of_previous_step  --output hdf5_cohortsA_he_test.h5   --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='test'

mpirun -n 40 python DeepPATH_code/00_preprocessing/0e_jpgtoHDF.py  --input_path path_to_output_of_previous_step --output hdf5_cohortsA_he_validation.h5 --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='valid'

```

For the additional test cohort, only the corrsponding 'test' h5 file script needs to be run.

All subsequent steps are related to libraries from the [HPL pipeline](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning). Please refer to that page for any description regarding the option and usage of the library, as well requirements regarding file organization and naming schemes. for completeness, in addition to providing the python script and option used, the command pnd files rovided below show example of script headers for submissions on slurm environements.

## 2. Self-supervised processing

**2.a. Training**
```shell
sbatch sb_01_train.sh
```

**2.b. Projection of the whole development cohort (cohortA) and the external test (cohortB) into the trained network**
```shell
sbatch sb_02_project.sh
```

**2.c. Combine the h5 files from the development cohort into 1 h5 file for future processing**
```shell
sb_03_combine.sh
``` 

**2.d. Add information about clinical data into the h5 file**
These labels will only be used for the Cox regression study run at the end, or can contain any information used for other final statistical analysis.
```shell
sbatch sb_04_AddField.sh
```
Note: the  `labels.csv` files contains the clinical data with the following columns:
  * `samples`: patient ID (in our case, the first ~6 characters of the file names)
  * `os_event_data`: survival (in months)
  * `os_event_ind`: event (1: event; 0: no event)
  * `stage`: stage of the tumor
  * `treatment`: name of the treatment
  * `treatment_category`: category or treatment (antiCTLA4 for example)
  * `data_source`: name of the source institution  


**2.e. Leiden clustering**
```shell
for resolution in  0.1 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.5 3.0 3.5 4.0 4.5 5.0 6.0 7.0 8.0 9.0
do 
sbatch --job-name=05_cluster_r${resolution} --output=rq_05_cluster_r${resolution}_%A_%a_200k.out  --error=rq_05_cluster_r${resolution}_%A_%a_200k.err sb_05_Cluster.sh $resolution
done
```

The entry `utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl` was obtained using the [HPL fold creation script](https://github.com/AdalbertoCq/Histomorphological-Phenotype-Learning/tree/master/utilities/fold_creation). 


**2.f. Identify optimal Leiden resolution to use:**
```shell
sbatch
sb_05b_assess_clusters.sh
```


**2.g. Generate 100 random tiles from each cluster for visual assessment by pathologists:**
```shell
sb_06_RepTiles.sh
```


**2.h. Run Cox regression on all Leiden resolution folds:**
```shell
sbatch sb_07_CoxReg.sh
```
Notes:
- This needs to be run first without then with the `force_fold` option to explore variability between folds, then with force option to potentially focus on a given fold.
- To potentially run the Cox regression on a subset of samples (for example, only the subset linked to anti-CTLA4 treatment), it is sufficient to generate another `folds_pickle` file with only the samples of interest listed in the different folds. The external cohort in the `nadd` variable will need to be filtered accordingly.
- In the `report_representationsleiden_cox.py` script from HPL, you can modify the sets of leiden resolutions of interest

**2.i. Run Cox regression on a given Leiden resolution fold to generate the Kaplan-Meier curve:**
```shell
sbatch sb_08_CoxReg_Indiv.sh
```

