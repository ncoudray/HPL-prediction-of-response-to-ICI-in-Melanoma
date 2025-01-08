#!/bin/bash
#SBATCH --partition=gpu8_long,gpu4_long
#SBATCH --job-name=01_train
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --output=rq_01_train_%A_%a.out
#SBATCH  --error=rq_01_train_%A_%a.err
#SBATCH --mem=20G
#SBATCH --gres=gpu:1


module load pathganplus/3.8.11

python3 run_representationspathology.py --img_size 224 --batch_size 64 --epochs 120 --z_dim 128 --model BarlowTwins_3 --dataset cohortsA --check_every 10 --report


 



