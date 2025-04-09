#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G

#SBATCH  --job-name=TCGA_08
#SBATCH --output=log_TCGA_08_%A_%a.out
#SBATCH  --error=log_TCGA_08_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37


#### comb 005
 all_ind=os_event_ind
 all_data=os_event_data



Opt=3
if [ ${Opt} -eq 1 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_TCGA
    all_pickle=up_comb005_001_all_os_4folds.pkl

elif [ ${Opt} -eq 2 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    ff=3
    all_meta=comb005_v01_OS_002_ff${ff}_TCGA
    all_pickle=up_comb005_002_all_os_4folds_antiCTLA4.pkl


elif [ ${Opt} -eq 3 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    ff=3
    all_meta=comb005_v01_OS_003_ff${ff}_TCGA
    all_pickle=up_comb005_003_all_os_4folds_antiPD1.pkl


elif [ ${Opt} -eq 4 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    ff=3
    all_meta=comb005_v01_OS_004_ff${ff}_TCGA
    all_pickle=up_comb005_004_all_os_4folds_antiPD1andCTLA4.pkl


elif [ ${Opt} -eq 5 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_allosNYU.h5
    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_NYU
    all_pickle=up_comb005_001_all_os_4folds.pkl

elif [ ${Opt} -eq 6 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4.h5
    ff=3
    all_meta=comb005_v01_OS_002_ff${ff}_NYU
    all_pickle=up_comb005_002_all_os_4folds_antiCTLA4.pkl


elif [ ${Opt} -eq 7 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1.h5
    ff=3
    all_meta=comb005_v01_OS_003_ff${ff}_NYU
    all_pickle=up_comb005_003_all_os_4folds_antiPD1.pkl


elif [ ${Opt} -eq 8 ]
then
    nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_both.h5
    ff=3
    all_meta=comb005_v01_OS_004_ff${ff}_NYU
    all_pickle=up_comb005_004_all_os_4folds_antiPD1andCTLA4.pkl

fi

python3 ./report_representationsleiden_cox_comb45_all.py \
 --meta_folder  ${all_meta} \
 --matching_field samples \
 --event_ind_field ${all_ind} \
 --event_data_field ${all_data} \
 --min_tiles 10 \
 --folds_pickle ${all_pickle} \
 --h5_complete_path    results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_trainE_40x_896px_he_complete_allos.h5 \
 --h5_additional_path  ${nadd} \
  --force_fold ${ff}








