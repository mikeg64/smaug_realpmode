#!/bin/bash
#$ -j y
#$ -V 
#$ -N tsecs2a
#$ -l mem=18G

#$ -l rmem=18G
##$ -l rmem=18G
##$ -l h_rt=8:00:00
##module add libs/cuda/4.0.17
#module add libs/cuda/6.5.14
module load apps/matlab/2014a
#module load apps/matlab



#export TIMECOUNTER=0
#source timeused
#   matlab -nosplash -r "plot_example_secs_array2"

 matlab -nosplash -r "plotsecsp_isocontour_2d_array"


#source timeused

