#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /work/sunnylin/self_assembly_design/modeltest/4_remove_met_trp/;
for i in *pdb;do
	mkdir ${i%.*};
	cd ${i%.*};
	cp .;
	cd ../;
done



