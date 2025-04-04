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
nadd=results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5


Opt=4

if [ ${Opt} -eq 1 ]
then
	ff=3
        nfolder=comb005_v01_OS_001_ff${ff}
	all_pickle=comb005_001_all_os_4folds.pkl
	nres=2.0
        nlrat=0.0
        nalpha=10

elif [ ${Opt} -eq 2 ]
then
	ff=3
	nfolder=comb005_v01_OS_002_ff${ff}
	all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
	nres=2.0
	nlrat=0.0
	#nalpha=10
	#nalpha=0.9
	nalpha=0.5
	#nlrat=0.1
	#nalpha=1.2

elif [ ${Opt} -eq 22 ]
then
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_selected_HPC
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
	remove_clusters_type=anti-CTLA4
elif [ ${Opt} -eq 230 ]
then
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_antiCTLA4
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
	remove_clusters_type='None'

elif [ ${Opt} -eq 231 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_LN.h5
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_LN
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
        remove_clusters_type='None'

elif [ ${Opt} -eq 232 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_ST.h5
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_ST
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
        remove_clusters_type='None'


elif [ ${Opt} -eq 233 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4.h5
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_antiCTLA4_selected_HPC
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
	#naplha=0.05
        remove_clusters_type=anti-CTLA4

elif [ ${Opt} -eq 234 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_ST.h5
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_ST_selected_HPC
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
	#nalpha=0.05
        remove_clusters_type=anti-CTLA4

elif [ ${Opt} -eq 235 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiCTLA4_LN.h5
        ff=3
        nfolder=comb005_v01_OS_002_ff${ff}_LN_selected_HPC
        all_pickle=comb005_002_all_os_4folds_antiCTLA4.pkl
        nres=2.0
        nlrat=0.0
        nalpha=10
        nalpha=0.05
	remove_clusters_type=anti-CTLA4

elif [ ${Opt} -eq 3 ]
then
	#nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_allosNYU.h5 
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        #nalpha=15
	nalpha=5

elif [ ${Opt} -eq 32 ]
then
	#nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_allosNYU.h5 
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_selected_HPC
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        # nalpha=5
	remove_clusters_type=anti-PD1


elif [ ${Opt} -eq 330 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1.h5
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_antiPD1
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        # nalpha=5
	#nalpha=100
        remove_clusters_type='None'

elif [ ${Opt} -eq 331 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1_LN.h5
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_LN
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        # nalpha=5
        remove_clusters_type='None'

elif [ ${Opt} -eq 332 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1_ST.h5
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_ST
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        # nalpha=5
        remove_clusters_type='None'


elif [ ${Opt} -eq 333 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1.h5
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_antiPD1_selected_HPC
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        nalpha=100
        remove_clusters_type=anti-PD1

elif [ ${Opt} -eq 334 ]
then
        #nadd=results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_NYU005_0u2525_896pxx_he_combined_antiPD1_ST.h5
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_ST_selected_HPC
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        #nalpha=100
        remove_clusters_type=anti-PD1

elif [ ${Opt} -eq 335 ]
then
        ff=3
        nfolder=comb005_v01_OS_003_ff${ff}_LN_selected_HPC
        all_pickle=comb005_003_all_os_4folds_antiPD1.pkl
        nres=2.0
        nlrat=0.0
        nalpha=15
        #nalpha=100
        remove_clusters_type=anti-PD1


elif [ ${Opt} -eq 4 ]
then
        ff=3
        nfolder=comb005_v01_OS_004_ff${ff}
        all_pickle=comb005_004_all_os_4folds_antiPD1andCTLA4.pkl
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
 --h5_complete_path    results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_5setsNoNYU_40x_896px_he_complete_allos.h5  \
 --h5_additional_path  ${nadd} \
--resolution ${nres} \
--force_fold ${ff} \
--l1_ratio  ${nlrat} \
--alpha ${nalpha}  \
--min_tiles 10  \
--remove_clusters_type ${remove_clusters_type}


