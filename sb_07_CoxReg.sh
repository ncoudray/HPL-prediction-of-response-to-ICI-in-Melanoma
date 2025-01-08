#!/bin/bash
#SBATCH --partition=gpu4_medium,gpu8_medium
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G



#SBATCH  --job-name=07_Cox
#SBATCH --output=rq_07_Cox_%A_%a.out
#SBATCH  --error=rq_07_Cox_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37

all_ind=os_event_ind
all_data=os_event_data
all_meta=comb005_v01
all_pickle=utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl
nadd=results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsB_he_complete_OS.h5
ff=3



python3 ./report_representationsleiden_cox.py \
 --meta_folder  ${all_meta} \
 --matching_field samples \
 --event_ind_field ${all_ind} \
 --event_data_field ${all_data} \
 --min_tiles 10 \
 --folds_pickle ${all_pickle} \
 --h5_complete_path   results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete_OS.h5 \
 --h5_additional_path  ${nadd} \
 --force_fold ${ff}















