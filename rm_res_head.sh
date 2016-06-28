#!/bin/bash

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1;
for i in */;do cd $i;j=1;for k in *pdb;do mkdir $j; mv $k $j;mv ${k//pdb/res} $j;let j=j+1;done;cd ../;done &

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1;
find `pwd` -name *pdb >pdb_list_absolute_1 
for i in `cat pdb_list_absolute_1 `;do dirname $i;done >dir_list_1

for i in `cat dir_list_1`; do cd $i; sed -i '/^ / d' *.res;rm done; done & 
