#!/bin/bash
#SBATCH --partition=gpu4_medium
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30G

#SBATCH  --job-name=04_Add_Header
#SBATCH --output=rq_04_Add_Header_%A_%a.out
#SBATCH  --error=rq_04_Add_Header_%A_%a.err


module load pathganplus/3.6



python3 ./utilities/h5_handling/nc_create_metadata_h5.py \
  --meta_file labels_cohortsA.csv \
  --matching_field sampls \
  --list_meta_field  os_event_ind os_event_data stage treatment treatment_category data_source  \
  --h5_file  results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsA_he_complete.h5
  --meta_name OS

python3 ./utilities/h5_handling/nc_create_metadata_h5.py \
  --meta_file labels_cohortsB.csv \
  --matching_field sampls \
  --list_meta_field  os_event_ind os_event_data stage treatment treatment_category data_source \
  --h5_file  results/BarlowTwins_3_twentyE/cohortsA/h224_w224_n3_zdim128/hdf5_cohortsB_he_combined.h5 \
  --meta_name OS








