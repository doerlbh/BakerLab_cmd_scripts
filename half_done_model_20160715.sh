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

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;

find `pwd` -name "HBNet_*.pdb" > 20160715_pdblist;
for i in `cat 20160715_pdblist `;do dirname $i;done > 20160715_dirlist;

cat 20160715_dirlist | uniq -d > 20160715_uniqdirlist;
sort 20160715_uniqdirlist > 20160715_uniqdirlistsorted;
sort 20160706_uniqdonelist > 20160706_uniqdonelistsorted;

comm -23 20160715_uniqdirlistsorted 20160706_uniqdonelistsorted > 20160715only_dirlist;

for i in `cat 20160715only_dirlist`
	do cd $i;
		if [ -f done ];
			then echo `pwd` >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_donelist;
				find `pwd` -name "HBNet_*.pdb" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_modelpdblist;
				find `pwd` -name "HBNet_*.res" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_modelreslist;
			else echo `pwd` >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_unfinishedlist;
		fi;
	cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
done

