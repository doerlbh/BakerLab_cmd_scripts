#!/bin/bash
#Author: Baihan Lin
#Lab: Baker Lab

cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" 20160706_uniqdonelist > 20160706_uniqdonelist_C2

cp 20160706_uniqdonelist_C2 C2_sym.s

sed -i -e 's/^/cd /' *_sym.sh
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log#' C3_sym.sh

cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist |wc

 wc -l symm_seq.run 

for i in `cat rm_reshead`; do cd $i; rm done; done & 

comm -23 20160715_dirlist 20160706_donelist > 20160715only_dirlist;