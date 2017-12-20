#!/bin/bash
#$ -j y
#$ -V 
#$ -N jvproc30_00_y
#$ -l mem=12G
#$ -l rmem=12G
##$ -l h_rt=8:00:00
##module add libs/cuda/4.0.17
##module add libs/cuda/6.5.14

module load apps/matlab



#export TIMECOUNTER=0
#source timeused
   matlab -nosplash -nojvm -r "pvvt30_00_y"
#source timeused

