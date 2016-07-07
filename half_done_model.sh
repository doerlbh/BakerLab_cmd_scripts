#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
#for i in [0-9];
#	do cd $i;
#	for j in *pdb;
#		do if [ -f done ];
#			then echo `pwd` >> 20160706_donelist;
#			else echo `pwd` >> 20160706_unfinishedlist;
#		fi;
#	cd ../;
#	done;
#done;

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/
find `pwd` -name "HBNet_*.pdb" > 20160706_pdblist
for i in `cat 20160706_pdblist `;do dirname $i;done > 20160706_dirlist

for i in `cat 20160706_dirlist`; 
	do cd $i;
		if [ -f done ];
			then echo `pwd` >> 20160706_donelist;
				find `pwd` -name "HBNet_*.pdb" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_modelpdblist
				find `pwd` -name "HBNet_*.res" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_modelreslist
			else echo $i >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_unfinishedlist;
		fi;
	cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/
done

cp  20160706_modelpdblist model_out.sh
cat 20160706_modelreslist >> model_out.sh
mkdir 20160706_HBNet_models

sed -i -e 's/^/cp /' model_out.sh
sed -i 's#$# /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_HBNet_models#' design_out.sh

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_HBNet_models;
j=1;
for k in *pdb;
	do mkdir $j; 
		mv $k $j;
		mv ${k//pdb/res} $j;
		let j=j+1;
	done;

sh model_out.sh

