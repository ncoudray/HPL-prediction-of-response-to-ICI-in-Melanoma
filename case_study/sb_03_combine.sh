#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G
#SBATCH --gres=gpu:1

#SBATCH  --job-name=TCGA_03
#SBATCH --output=log_TCGA_03_%A_%a.out
#SBATCH  --error=log_TCGA_03_%A_%a.err

module load pathganplus/3.6




##### Combb 5
python3 ./utilities/h5_handling/combine_complete_h5.py \
 --img_size 224 \
 --z_dim 128 \
 --dataset comb005_TCGA_40x_896px \
 --model BarlowTwins_3_twentyE






