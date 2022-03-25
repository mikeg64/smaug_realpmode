#!/bin/bash

#$ -l mem=16G
#$ -l rmem=16G
#$ -N convert2h5
#$ -j y
##$ -t 5-8:1
#$ -V 

#$ -l h_rt=8:00:00


##module add libs/cuda/4.0.17
#module add libs/cuda/6.5.14
module load apps/matlab/2018b


#export TIMECOUNTER=0
#source timeused
  matlab -nosplash -r "sac3Dtohdf5"
#source timeused

#cd /fastdata/cs1mkg/smaug_wash/washmc_2p5_2p5_12p5_mach180_uni6

cd /shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G

tar -zcvf h5min.tgz h5min