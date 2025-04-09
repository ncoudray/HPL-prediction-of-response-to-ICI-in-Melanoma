#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH  --job-name=TCGA_09
#SBATCH --output=log_TCGA_09_%A_%a.out
#SBATCH  --error=log_TCGA_09_%A_%a.err


unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37


all_ind=os_event_ind
all_data=os_event_data
remove_clusters_type=None


Opt=2
if [ ${Opt} -eq 1 ]
then
    	nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
   	ff=3
    	nfolder=comb005_v01_OS_001_ff${ff}_TCGA
    	all_pickle=up_comb005_001_all_os_4folds.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10.
        remove_clusters_type='allT'
        #remove_clusters_type='None'

elif [ ${Opt} -eq 2 ]
then
    	nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    	ff=3
    	nfolder=comb005_v01_OS_002_ff${ff}_TCGA
    	all_pickle=up_comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10.
        remove_clusters_type='anti-CTLA4'
	#remove_clusters_type='None'

elif [ ${Opt} -eq 3 ]
then
    	nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
    	ff=3
    	nfolder=comb005_v01_OS_003_ff${ff}_TCGA
    	all_pickle=up_comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10.
        remove_clusters_type='anti-PD1'
	#remove_clusters_type='None'

elif [ ${Opt} -eq 4 ]
then
	nadd=results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
        ff=3
        nfolder=comb005_v01_OS_004_ff${ff}_TCGA
    	all_pickle=up_comb005_004_all_os_4folds_antiPD1andCTLA4.pkl
	nres=2.0
        nlrat=0.0
        nalpha=0.07
        remove_clusters_type='both'
	#remove_clusters_type='None'


elif [ ${Opt} -eq 5 ]
then
	nadd=results/BarlowTwins_3_twentyE/BarlowTwins_3_twentyE/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_allosNYU.h5
	ff=3
	nfolder=comb005_v01_OS_001_ff${ff}_NYU
	all_pickle=up_comb005_001_all_os_4folds.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10.
	remove_clusters_type='allT'

elif [ ${Opt} -eq 6 ]
then
	nadd=results/BarlowTwins_3_twentyE/BarlowTwins_3_twentyE/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4.h5
	ff=3
	nfolder=comb005_v01_OS_002_ff${ff}_NYU
	all_pickle=up_comb005_002_all_os_4folds_antiCTLA4.pkl
	nres=2.0
        nlrat=0.0
        nalpha=10
	remove_clusters_type='anti-CTLA4'


elif [ ${Opt} -eq 7 ]
then
	nadd=results/BarlowTwins_3_twentyE/BarlowTwins_3_twentyE/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1.h5
	ff=3
	nfolder=comb005_v01_OS_003_ff${ff}_NYU
	all_pickle=up_comb005_003_all_os_4folds_antiPD1.pkl
	nres=2.0
	nlrat=0.0
	nalpha=10
	remove_clusters_type='anti-PD1'


elif [ ${Opt} -eq 8 ]
then
	nadd=results/BarlowTwins_3_twentyE/BarlowTwins_3_twentyE/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_both.h5
	ff=3
	nfolder=comb005_v01_OS_004_ff${ff}_NYU
	all_pickle=up_comb005_004_all_os_4folds_antiPD1andCTLA4.pkl
	nres=2.0
        nlrat=0.0
        nalpha=0.07
        remove_clusters_type='both'
fi

python3 ./report_representationsleiden_cox_individual_Selected_HPC.py \
--meta_folder ${nfolder} \
--matching_field samples \
--event_ind_field ${all_ind} \
--event_data_field ${all_data} \
--folds_pickle ${all_pickle} \
 --h5_complete_path    results/BarlowTwins_3_twentyE/comb005_trainE_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_trainE_40x_896px_he_complete_allos.h5 \
 --h5_additional_path  ${nadd} \
--resolution ${nres} \
--force_fold ${ff} \
--l1_ratio  ${nlrat} \
--alpha ${nalpha}  \
--min_tiles 10  \
--remove_clusters_type ${remove_clusters_type}


