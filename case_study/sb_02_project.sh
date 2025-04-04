#!/bin/bash
#SBATCH --partition=gpu4_medium,gpu8_medium,gpu8_long,gpu4_long
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --gres=gpu:1

#SBATCH  --job-name=TCGA_02
#SBATCH --output=log_TCGA_02_%A_%a.out
#SBATCH  --error=log_TCGA_02_%A_%a.err



module load pathganplus/3.6


python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt  \
 --real_hdf5 datasets/comb005_TCGA_40x_896px/he/patches_h224_w224/hdf5_comb005_TCGA_40x_896px_he_train.h5 \
 --dataset comb005_TCGA_40x_896px \
 --model BarlowTwins_3_twentyE



python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt  \
 --real_hdf5 datasets/comb005_TCGA_40x_896px/he/patches_h224_w224/hdf5_comb005_TCGA_40x_896px_he_test.h5 \
 --dataset comb005_TCGA_40x_896px \
 --model BarlowTwins_3_twentyE


python3 ./run_representationspathology_projection.py \
 --checkpoint data_model_output/BarlowTwins_3/comb005_5setsNoNYU_40x_896px/h224_w224_n3_zdim128/results/epoch_20/checkpoints/BarlowTwins_3.ckt  \
 --real_hdf5 datasets/comb005_TCGA_40x_896px/he/patches_h224_w224/hdf5_comb005_TCGA_40x_896px_he_validation.h5 \
 --dataset comb005_TCGA_40x_896px \
 --model BarlowTwins_3_twentyE



