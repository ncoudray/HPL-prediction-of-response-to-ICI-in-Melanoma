#!/bin/bash
#SBATCH --partition=gpu4_dev
#SBATCH --job-name=Sort_tr
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --output=rq_sort_tr_%A_%a.out
#SBATCH --error=rq_sort_tr_%A_%a.err
#SBATCH --mem=20GB
###SBATCH --time=3:00:00

module load anaconda3/gpu/5.2.0
conda activate /gpfs/data/coudraylab/NN/env/env_deepPath
unset PYTHONPATH
export PATH="/gpfs/data/coudraylab/NN/env/env_deepPath/bin/:$PATH"



python /gpfs/data/coudraylab/NN/github/DeepPATH_code/00_preprocessing/0d_SortTiles.py --SourceFolder='../896px_0um2525_B40_20250221_TCGA'  --Magnification=0.2525  --MagDiffAllowed=0 --SortingOption=14 --JsonFile="selected_TCGA.txt"  --PatientID=12 --nSplit 0 --Balance=2  --PercentValid=25 --PercentTest=25



