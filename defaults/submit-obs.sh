#!/bin/bash

#SBATCH -N 1
#SBATCH -c 16
#SBATCH -t 36:00:00

#Set variables

export MESASDK_ROOT=$HOME/src/sdk/mesasdk
source $MESASDK_ROOT/bin/mesasdk_init.sh

source $HOME/src/cmfgen/com/aliases_for_cmfgen.sh

module load python/3.5.0

cd $SLURM_SUBMIT_DIR

export OMP_NUM_THREADS=16

pwd

#~/bin/cleanup.sh
python3 ~/src/cmfgenPlot/newModel.py
