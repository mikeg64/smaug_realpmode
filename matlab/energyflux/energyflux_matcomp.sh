#!/bin/bash
#$ -j y
#$ -V 
#$ -N ef4p35
##$ -l mem=12G
#$ -l rmem=18G
##$ -l h_rt=8:00:00


module load apps/matlab


#tar -zxvf spic2p82a_0_0.tgz
#export TIMECOUNTER=0
#source timeused
   matlab -nosplash -nojvm -r "energyperunitarea_array"
#source timeused

#/bin/rm -rf spic2p82a_0_0_3d

