#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G


#SBATCH  --job-name=TCGA_19
#SBATCH --output=log_TCGA_19_%A_%a.out
#SBATCH  --error=log_TCGA_19_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37



all_ind=os_event_ind
all_data=os_event_data
remove_clusters_type=None

nadd=results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5


Opt=7
if [ ${Opt} -eq 1 ]
then
	ff=3
        nfolder=comb005_v01_OS_001_ff${ff}_add_os1
	all_pickle=overall_survival_TCGA_folds_os.pkl_1
	nres=2.0
	#nlrat=0.2
	#nalpha=0.56

        nlrat=0.0
        nalpha=9



elif [ ${Opt} -eq 2 ]
then
        ff=3
        nfolder=comb005_v01_OS_001_ff${ff}_add_os2
        all_pickle=overall_survival_TCGA_folds_os.pkl_2
        nres=2.0
        nlrat=0.0
        nalpha=0.02

elif [ ${Opt} -eq 3 ]
then
	ff=3
	nfolder=comb005_v01_OS_001_ff${ff}_add_rfs
	all_pickle=overall_survival_TCGA_folds_rfs.pkl
	nres=2.0
	nlrat=0.0
	nalpha=0.2



elif [ ${Opt} -eq 4 ]
then
        ff=3
        nfolder=comb005_v01_OS_001_ff${ff}_add_os4
        all_pickle=overall_survival_TCGA_3folds_os.pkl
        nres=2.0
        nlrat=0.2
        nalpha=0.44

elif [ ${Opt} -eq 5 ]
then
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_antiPD1_selected_HPC
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        remove_clusters_type=anti-PD1

elif [ ${Opt} -eq 6 ]
then
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_anti_CTLA4_selected_HPC
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
        remove_clusters_type=anti-CTLA4


elif [ ${Opt} -eq 7 ]
then
        ff=3
        nfolder=comb005_v01_OS_001_ff${ff}_selected_HPC
        all_pickle=comb005_001_all_os_4folds.pkl
        nres=2.0

        nlrat=0.0
        nalpha=9
        remove_clusters_type=allT

fi

python3 ./report_representationsleiden_cox_individual_Selected_HPC.py \
--meta_folder ${nfolder} \
--matching_field samples \
--event_ind_field ${all_ind} \
--event_data_field ${all_data} \
--folds_pickle ${all_pickle} \
 --h5_complete_path    results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_5setsNoNYU_40x_896px_he_complete_allos.h5  \
 --h5_additional_path  ${nadd} \
--resolution ${nres} \
--force_fold ${ff} \
--l1_ratio  ${nlrat} \
--alpha ${nalpha}  \
--min_tiles 10  \
 --remove_clusters_type ${remove_clusters_type}
#--additional_as_fold \


