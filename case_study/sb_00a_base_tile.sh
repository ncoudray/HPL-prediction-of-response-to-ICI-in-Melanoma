#!/bin/bash
# #SBATCH --partition=fn_medium,fn_long,gpu4_medium,gpu4_long,gpu8_medium,gpu8_long
#SBATCH --partition=fn_short,fn_medium,fn_long
# #SBATCH --partition=gpu4_dev
#SBATCH --cpus-per-task=20
#SBATCH --mem=30GB

# module load python/gpu/3.6.5
#module unload python/gpu/3.6.5
module load anaconda3/gpu/5.2.0
#conda activate /gpfs/data/coudraylab/NN/env/env_deepPath_3
conda activate /gpfs/data/coudraylab/NN/env/env_deepPath
unset PYTHONPATH
export PATH="/gpfs/data/coudraylab/NN/env/env_deepPath/bin/:$PATH"

#module load anaconda3/gpu/5.2.0
#conda activate /gpfs/data/coudraylab/NN/env/env_deepPath
#module load condaenvs/gpu/deeppath_env_conda3_376
#unset PYTHONPATH



echo $@

python /gpfs/data/coudraylab/NN/github/DeepPATH_code/00_preprocessing/0b_tileLoop_deepzoom6.py $@
# python /gpfs/data/coudraylab/NN/github/DeepPATH_code/00_preprocessing/0b_tileLoop_deepzoom4.py $@



