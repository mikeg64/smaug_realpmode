#!/bin/bash
#$ -j y
#$ -V 
#$ -l arch=intel*
##$ -l gpu=1,gpu_arch=nvidia-k40m
#$ -l gpu=1,gpu_arch=nvidia-m2070
##$ -P cs-test
##$ -P gpu
#$ -P mhd
#$ -N j3p00a_0_1_b20g
#$ -l mem=12G
#$ -l rmem=12G
#$ -l h_rt=168:00:00
module add libs/cuda/6.5.14

#cp solarmodels/Makefile.spicule src/Makefile
#cp solarmodels/make_inputs.spicule src/make_inputs
#cp solarmodels/iosac2.5d.cpp.spicule src/iosac2.5d.cpp

#cp solarmodels/boundary.cu.spicule src/boundary.cu
#cp solarmodels/init_user.cu.spicule src/init_user.cu

#cp solarmodels/usersource.cu.spicule4 src/usersource.cu
#cp solarmodels/iosmaugparams.h.spicule4 include/iosmaugparams.h

#cd src
#make clean
#make smaug
#cd ..

cd include
cp iosmaugparams3p00a_0_1_b20gv.h iosmaugparams.h
cd ..

cd src
cp usersource3p00a_0_1_b1v.cu usersource.cu
cp boundary_3d.cu boundary.cu
make clean
#make -f Makefile_3d_k40 smaug
make -f Makefile_3d smaug

cd ..



export TIMECOUNTER=0
source timeused
./smaug a
source timeused

