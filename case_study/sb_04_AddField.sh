#!/bin/bash
#SBATCH --partition=gpu4_dev,gpu4_short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G

#SBATCH  --job-name=TCGA_04
#SBATCH --output=log_TCGA_04_%A_%a.out
#SBATCH  --error=log_TCGA_04_%A_%a.err


module load pathganplus/3.6





python3 ./utilities/h5_handling/nc_create_metadata_h5.py \
  --meta_file   labels_TCGA_unique.txt \
  --matching_field samples \
  --list_meta_field os_event_ind os_event_data data_source pfs_event_ind pfs_event_data \
  --h5_file results/BarlowTwins_3_twentyE/comb005_TCGA_40x_896px/h224_w224_n3_zdim128/hdf5_comb005_TCGA_40x_896px_he_complete.h5 \
  --meta_name OS



