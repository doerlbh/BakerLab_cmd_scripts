#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/;
for i in *pdb;do
	mkdir ${i%.*};
	cp $i ${i%.*};
	cd ${i%.*};
	cp ../design.res ${i%.*}_design.res;
	cp ../design.res temp_design.res;
	cp ../heterodimer_final_design.flags .;
	cp ../heterodimer_final_design.xml ${i%.*}_heterodimer_final_design.xml;
	sed -i "s#/work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/design.res#/work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/${i%.*}/${i%.*}_design.res#g" ${i%.*}_heterodimer_final_design.xml;
	grep "MET A " $i | cut -c24-26 | sed 's#$# A NOTAA M#' >> temp_design.res;
	grep "MET B " $i | cut -c24-26 | sed 's#$# B NOTAA M#' >> temp_design.res;
	grep "TRP A " $i | cut -c24-26 | sed 's#$# A NOTAA W#' >> temp_design.res;
	grep "TRP B " $i | cut -c24-26 | sed 's#$# B NOTAA W#' >> temp_design.res;
	uniq temp_design.res > ${i%.*}_design.res;
	cd ../;
done

#240 B NOTAA W

for i in */; do
	cd $i;
/work/zibochen/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease -s *.pdb @heterodimer_final_design.flags -parser:protocol *.xml
cd ../;
done
