#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G



#SBATCH  --job-name=TCGA_18
#SBATCH --output=log_TCGA_18_%A_%a.out
#SBATCH  --error=log_TCGA_18_%A_%a.err



unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37





#### comb 005
 all_ind=os_event_ind
 all_data=os_event_data


all_meta=comb005_v01
## all_pickle=utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl

nadd=results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5


Opt=6
if [ ${Opt} -eq 1 ]
then

    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_add_os1
    all_pickle=overall_survival_TCGA_folds_os.pkl_1

elif [ ${Opt} -eq 2 ]
then

    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_add_os2
    all_pickle=overall_survival_TCGA_folds_os.pkl_2

elif [ ${Opt} -eq 3 ]
then

    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_add_rfs
    all_pickle=overall_survival_TCGA_folds_rfs.pkl


elif [ ${Opt} -eq 4 ]
then

    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}_add_os4
    all_pickle=overall_survival_TCGA_3folds_os.pkl

elif [ ${Opt} -eq 5 ]
then

    ff=3
    all_meta=comb005_v01_OS_003_ff${ff}_antiPD1_selected_HPC
    all_pickle=comb005_003_all_os_4folds_antiPD1.pkl


elif [ ${Opt} -eq 6 ]
then

    ff=3
    all_meta=comb005_v01_OS_002_ff${ff}_anti_CTLA4_selected_HPC
    all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl

fi





python3 ./report_representationsleiden_cox_comb45_all.py \
 --meta_folder  ${all_meta} \
 --matching_field samples \
 --event_ind_field ${all_ind} \
 --event_data_field ${all_data} \
 --min_tiles 10 \
 --folds_pickle ${all_pickle} \
 --h5_complete_path    results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_5setsNoNYU_40x_896px_he_complete_allos.h5  \
 --h5_additional_path  ${nadd} \
 --force_fold ${ff} \
# --additional_as_fold








