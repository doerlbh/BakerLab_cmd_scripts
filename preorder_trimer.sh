#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /work/sunnylin/self_assembly_design/model_preorder/selected/;
for i in */;do
cd $i;
for i in *.pdb; do
	grep "^ATOM..* B " $i > "B_$i"
	grep "^ATOM..* A " $i > "A_$i"
done

python /work/sunnylin/self_assembly_design/flatland_add_loop_from_pdb_trimer.py
cd ../;
done
