#!/bin/bash
#Author: Baihan Lin
#Date: August 2016
#Lab: Baker Lab

now=$(date +"%Y%m%d")

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;

find `pwd` -name "HBNet_*.pdb" > $now.pdblist;
for i in `cat $now.pdblist `;do dirname $i;done > $now.dirlist;

cat $now.dirlist | uniq -d > $now.uniqdirlist;
sort $now.uniqdirlist > $now.uniqdonelistsorted;

comm -23 $now.uniqdonelistsorted 20160715_uniqdirlistsorted > $now.only_dirlist;

for i in `cat $now.only_dirlist`
	do cd $i;
		if [ -f done ];
			then echo `pwd` >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.donelist;
				find `pwd` -name "HBNet_*.pdb" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.modelpdblist;
				find `pwd` -name "HBNet_*.res" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.modelreslist;
			else echo `pwd` >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.unfinishedlist;
		fi;
	cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
done

