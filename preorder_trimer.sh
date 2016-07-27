#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /work/sunnylin/self_assembly_design/model_preorder/selected/;
for i in */;do
cd $i;
for j in *.pdb; do
grep "^ATOM..* A " $j > "A_$j"
grep "^ATOM..* B " $j > "B_$j"
done
python /work/sunnylin/self_assembly_design/flatland_add_loop_from_pdb_trimer.py /work/sunnylin/self_assembly_design/benchmark/bobby_closed/XAAA_heteromonomer_ala.pdb A*.pdb A_$i_looped.pdb;
python /work/sunnylin/self_assembly_design/flatland_add_loop_from_pdb_trimer.py /work/sunnylin/self_assembly_design/benchmark/bobby_closed/XAAA_heteromonomer_ala.pdb B*.pdb A_$i_looped.pdb;
cd ../;
done
