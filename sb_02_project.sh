#!/bin/bash
# #SBATCH --partition=gpu4_medium,gpu8_medium,gpu8_long,gpu4_long
#SBATCH --partition=gpu4_dev
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --gres=gpu:1

#SBATCH  --job-name=02_project
#SBATCH --output=rq_02_project_%A_%a.out
#SBATCH  --error=rq_02_project_%A_%a.err



module load pathganplus/3.6

# development cohort:
python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt \
 --real_hdf5  dataset/cohortsA/he/patches_h224_w224/hdf5_cohortsA_he_validation.h5 \
 --dataset  cohortsA \
 --model BarlowTwins_3_twentyE_3

python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt \
 --real_hdf5  dataset/cohortsA/he/patches_h224_w224/hdf5_cohortsA_he_test.h5 \
 --dataset  cohortsA \
 --model BarlowTwins_3_twentyE_3

python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt \
 --real_hdf5  dataset/cohortsA/he/patches_h224_w224/hdf5_cohortsA_he_train.h5 \
 --dataset  cohortsA \
 --model BarlowTwins_3_twentyE_3


# Test cohort
python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt \
 --real_hdf5  dataset/cohortsB/he/patches_h224_w224/hdf5_cohortsB_he_test.h5 \
 --dataset  cohortsA \
 --model BarlowTwins_3_twentyE_3





