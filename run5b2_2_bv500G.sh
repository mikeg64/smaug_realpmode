#!/bin/bash
##sge for both
#$ -j y
#$ -l gpu=1
#$ -N m5b2_2_bv500G
#$ -l mem=12G






##sge for iceberg
#$ -l arch=intel*
#$ -l gpu_arch=nvidia-m2070
##$ -l gpu=1,gpu_arch=nvidia-k40m
##$ -P mhd
#$ -l rmem=12G
#$ -l h_rt=168:00:00

#module for sharc
#module load libs/CUDA/8.0.44/binary

#module for cuda m2070 on iceberg
module load libs/cuda/6.5.14







cd include
cp iosmaugparams5b2_2_bv500G_sharc.h iosmaugparams.h
cd ..

#cp smaug smaug_iceberg

cd src
cp usersource5b2_2.cu usersource.cu
cp boundary_3d.cu boundary.cu
make clean


#makefile for m2070 on iceberg
make -f Makefile_3d smaug

#make for Sharc
#make -f Makefile_3d_k80 smaug





cd ..

#cp smaug smaug_sharc
#cp smaug_iceberg smaug



#export TIMECOUNTER=0
#source timeused
./smaug a
#source timeused

