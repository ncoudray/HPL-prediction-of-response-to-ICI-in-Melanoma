#!/bin/bash
#SBATCH --partition=gpu4_dev,gpu4_short,gpu4_medium
#SBATCH --job-name=TCGAl
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --output=rq_TCGA_%A.out
#SBATCH --error=rq_TCGA_%A.err
#SBATCH --mem=70GB

module unload python
module load openmpi/3.1.0-mt
module load python/cpu/3.6.5


mpirun -n 40 python 0e_jpgtoHDF.py  --input_path sort_tiles --output hdf5_comb005_TCGA_40x_896px_he_train.h5  --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='train'  --sampleID=12

mpirun -n 40 python 0e_jpgtoHDF.py  --input_path sort_tiles --output hdf5_comb005_TCGA_40x_896px_he_validation.h5 --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='valid'  --sampleID=12

mpirun -n 40 python 0e_jpgtoHDF.py  --input_path sort_tiles --output hdf5_comb005_TCGA_40x_896px_he_test.h5 --chunks 40 --sub_chunks 20 --wSize 224 --mode 2 --subset='test'  --sampleID=12


