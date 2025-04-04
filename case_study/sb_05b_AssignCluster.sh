#!/bin/bash
#SBATCH --partition=fn_medium
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G


unset PYTHONPATH
x=$(printf %.2f $1)
echo $x

module load singularity/3.9.8
singularity shell  --bind /gpfs/data/osmanlab/Processing/HPL/Histomorphological-Phenotype-Learning_TCGA:/mnt docker://gcfntnu/scanpy:1.7.0 << eof
cd /mnt/


### all 006 on 005  
python3 ./run_representationsleiden_assignment.py \
 --meta_field comb005_v01 \
 --folds_pickle comb005_001_all_os_4folds.pkl \
 --h5_complete_path   results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_5setsNoNYU_40x_896px_he_complete_allos.h5  \
 --resolution $1 \
 --h5_additional_path results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5 

`		     # results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5
 
                     # results/BarlowTwins_3_twentyE/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete_OS.h5 
 

# for resolution in 2.0; do sbatch --job-name=TCGA_05_r${resolution} --output=log_TCGA_05_r${resolution}_%A_%a.out  --error=log_TCGA_05_r${resolution}_%A_%a.err sb_05b_AssignCluster.py $resolution; done




eof


