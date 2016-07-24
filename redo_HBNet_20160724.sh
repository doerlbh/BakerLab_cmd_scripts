#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab


#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/11/2;sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/run.sh;

now=$(date +"%Y%m%d")
find `pwd` -name "done" > done.$now;
for i in `cat done.$now`;do dirname $i;done > donedir.$now;

for i in  `cat donedir.$now`; 
do cd $i; 
#echo inside $i; 
if ! [ -f HBNet*.pdb ]; 
then echo `pwd` >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/fakedonedir.$now; 
#else echo yes there is HBNet; 
fi;
cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/; 
done

cp fakedonedir.$now redo_$now.sh 
sed -i -e 's/^/cd /' redo_$now.sh;
sed -i 's#$#; ;sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/run.sh;#' redo_$now.sh;


sudo pssu --create-set redoHBNet;

cat redo_$now.sh |psu --load --sql-set redoHBNet;

psu --stat --sql-set redoHBNet;
 
for i in `seq 10`;do qsub submit_redo_stf -W group_list=hyak-stf;done >>JOB_IDs_redoHBNet
for i in `seq 20`;do qsub submit_redo_baker -W group_list=hyak-baker;done >>JOB_IDs_redoHBNet


