#!/bin/bash
#SBATCH --partition=cpu_medium,cpu_long
#SBATCH --time=4-20:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G

unset PYTHONPATH



x=$(printf %.2f $1)
echo $x

module load singularity/3.9.8
singularity shell  --bind /gpfs/data/coudraylab/NN/Head_Neck/carucci/Histomorphological-Phenotype-Learning:/mnt docker://gcfntnu/scanpy:1.7.0 << eof
cd /mnt/






python3 ./run_representationsleiden.py \
 --meta_field comb005_v01 \
 --matching_field samples \
 --folds_pickle  utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl \
 --h5_complete_path   results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete_OS.h5 \
 --h5_additional_path results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsB_he_complete_OS.h5 \
 --resolution $1 \
 --subsample 300000



eof
