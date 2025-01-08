#!/bin/bash
#SBATCH --partition=gpu4_dev,gpu8_short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G

#SBATCH  --job-name=06_RepTiles
#SBATCH --output=rq_06_RepTiles_%A_%a.out
#SBATCH  --error=rq_06_RepTiles_%A_%a.err


unset PYTHONPATH
module load condaenvs/gpu/pathgan_SSL37


python3 ./report_representationsleiden_samples.py \
 --meta_folder comb005_v01 \
 --meta_field labels \
 --matching_field slides \
 --h5_complete_path   results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete_OS.h5 \
 --h5_additional_path results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsB_he_complete_OS.h5 \
 --fold 3 \
 --resolution 2.0 \
 --dpi 200 \
 --min_tiles 10 \
  --tile_img \
 --extensive \
 --dataset cohortsA





