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


all_meta=comb005_v01
all_pickle=utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl

nadd=results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5


Opt=2
if [ ${Opt} -eq 1 ]
then
    ff=None
    all_meta=comb005_v01
    all_pickle=comb005_001_all_os_4folds.pkl

elif [ ${Opt} -eq 2 ]
then

    ff=3
    all_meta=comb005_v01_OS_001_ff${ff}
    all_pickle=comb005_001_all_os_4folds.pkl

elif [ ${Opt} -eq 3 ]
then

    ff=3
    all_meta=comb005_v01_OS_002_ff${ff}
    all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
    #all_meta=comb005_v01_OS_002_ff${ff}_LN
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_LN.h5
    #all_meta=comb005_v01_OS_002_ff${ff}_ST
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_ST.h5
    #all_meta=comb005_v01_OS_002_ff${ff}_antiCTLA4
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4.h5


elif [ ${Opt} -eq 4 ]
then

    ff=3
    all_meta=comb005_v01_OS_003_ff${ff}
    all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
    #all_meta=comb005_v01_OS_003_ff${ff}_antiPD1
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1.h5
    #all_meta=comb005_v01_OS_003_ff${ff}_LN
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1_LN.h5
    #all_meta=comb005_v01_OS_003_ff${ff}_ST
    #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1_ST.h5


elif [ ${Opt} -eq 5 ]
then

    ff=3
    all_meta=comb005_v01_OS_004_ff${ff}
    all_pickle=comb005_004_all_os_4folds_antiPD1andCTLA4.pkl


#ff=3
#all_meta=comb005_v01_OS_Adj_005_ff${ff}
#all_pickle=utilities/comb005/fold_creation_v4/v01/comb006_os_Adj_all_Treatment_4folds.pkl
#all_pickle=utilities/comb005/fold_creation_v4/v02_forComb5/comb005_005_os_Adj_all_Treatment_4folds.pkl

#ff=3
#all_meta=comb005_v01_OS_Met_006_ff${ff}
##all_pickle=utilities/comb005/fold_creation_v4/v01/comb006_os_MET_all_Treatment_4folds.pkl
#all_pickle=utilities/comb005/fold_creation_v4/v02_forComb5/comb005_006_os_MET_all_Treatment_4folds.pkl

 #all_ind=pfs_event_ind
 #all_data=pfs_event_data

#ff=3
#all_meta=comb005_v01_PFS_Adj_013_ff${ff}
##all_pickle=utilities/comb005/fold_creation_v4/v01/comb006_pfs_MET_all_Treatment_4folds.pkl
#all_pickle=utilities/comb005/fold_creation_v4/v02_forComb5/comb005_013_rfs_Adj_all_Treatment_4folds.pkl


#ff=3
#all_meta=comb005_v01_RFS_Met_017_ff${ff}
##all_pickle=utilities/comb005/fold_creation_v4/v01/comb006_rfs_Adj_all_Treatment_4folds.pkl
#all_pickle=utilities/comb005/fold_creation_v4/v02_forComb5/comb005_017_pfs_MET_all_Treatment_4folds.pkl
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
 --force_fold ${ff}








