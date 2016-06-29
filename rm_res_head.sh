#!/bin/bash

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1
for i in */;do cd $i;j=1;for k in *pdb;do mkdir $j; mv $k $j;mv ${k//pdb/res} $j;let j=j+1;done;cd ../;done

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1
find `pwd` -name *pdb >pdb_list_absolute_1
for i in `cat pdb_list_absolute_1 `;do dirname $i;done >dir_list_1

for i in `cat dir_list_1`; do cd $i; sed -i '/^ / d' *.res;rm done; done

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1
cp dir_list_1 do_HBNet_1

sed -i -e 's/^/cd /' do_HBNet_1 
sed -i 's#$#;sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/run.sh;#' do_HBNet_1

cat do_HBNet_1 >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/do_HBNet

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling
cat do_HBNet |psu --load
for i in `seq 20`;do qsub submit_design -W group_list=hyak-stf;done >JOB_IDs
