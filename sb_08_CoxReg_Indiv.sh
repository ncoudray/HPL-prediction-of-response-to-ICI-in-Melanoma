#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G



#SBATCH  --job-name=08_CoxReg_ind
#SBATCH --output=rq_08_CoxReg_ind_%A_%a.out
#SBATCH  --error=rq_08_CoxReg_ind_%A_%a.err


unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37

all_ind=os_event_ind
all_data=os_event_data
nadd=results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsB_he_complete_OS.h5
remove_clusters_type=''
all_pickle=comb005_001_all_os_4folds.pkl
ff=3
nfolder=comb005_v01
nres=2.0
nlrat=0.0
nalpha=10



python3 ./report_representationsleiden_cox_individual_Selected_HPC.py \
--meta_folder ${nfolder} \
--matching_field samples \
--event_ind_field ${all_ind} \
--event_data_field ${all_data} \
--folds_pickle utilities/comb005/fold_creation/${all_pickle} \
 --h5_complete_path    results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete_OS.h5 \
 --h5_additional_path  ${nadd} \
--resolution ${nres} \
--force_fold ${ff} \
--l1_ratio  ${nlrat} \
--alpha ${nalpha}  \
--min_tiles 10  \
--remove_clusters_type ${remove_clusters_type}
	




