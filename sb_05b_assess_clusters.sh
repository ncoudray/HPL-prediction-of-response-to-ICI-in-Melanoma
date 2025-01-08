#!/bin/bash
#SBATCH --partition=a100_short
#SBATCH --job-name=05b_assessHPC
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --output=rq_05b_AssessHPC_%A_%a.out
#SBATCH  --error=rq_05b_AssessHPC_%A_%a.err
#SBATCH --mem=50G
#SBATCH --gres=gpu:1



module load pathganplus/3.8.11

python3 run_representationsleiden_evalutation.py \
 --meta_folder comb005_v01 \
 --folds_pickle  utilities/comb005/fold_creation/comb005_001_all_os_4folds.pkl \
 --h5_complete_path ./results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete_OS.h5 



