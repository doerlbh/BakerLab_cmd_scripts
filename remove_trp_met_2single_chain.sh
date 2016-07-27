#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/;
for i in *pdb;do
	mkdir ${i%.*};
	cd ${i%.*};
	cp ../design.res ${i%.*}_design.res;
	cp ../heterodimer_final_design.flags .;
	cp ../heterodimer_final_design.xml ${i%.*}_heterodimer_final_design.xml;
	sed -i 's#/work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/design.res#/work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/${i%.*}/${i%.*}_design.res#g' ${i%.*}_heterodimer_final_design.xml;
	grep "MET A " $i > metA_change;
	grep "MET B " $i > metB_change;
	cut -c20-22 metA_change;
done

#240 B NOTAA W

for i in */; do
	cd $i

/work/zibochen/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease -s input.pdb @heterodimer_final_design.flags -parser:protocol /work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/heterodimer_final_design.xml



<ReadResfile name=resfile filename="/work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/design.res" />

