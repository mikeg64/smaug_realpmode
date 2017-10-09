#!/bin/bash
#$ -j y
##$ -l arch=intel*
#$ -l gpu=1
##$ -l gpu_arch=nvidia-m2070
##$ -l gpu_arch=nvidia-k40m
##$ -l h=sharc-node099.shef.ac.uk
##$ -P gpu
#$ -N bv50G_2_2
#$ -l mem=12G
##$ -l rmem=12G
##$ -l h_rt=168:00:00
module load libs/CUDA/8.0.44/binary



cd include
cp iosmaugparams5b2_2_bv50G_sharc.h iosmaugparams.h
cd ..

#cp smaug smaug_iceberg

cd src
cp usersource5b2_2.cu usersource.cu
cp boundary_3d.cu boundary.cu
make clean
#make -f Makefile_3d smaug
make -f Makefile_3d_k80 smaug

cd ..

#cp smaug smaug_sharc
#cp smaug_iceberg smaug



#export TIMECOUNTER=0
#source timeused
./smaug a
#source timeused

