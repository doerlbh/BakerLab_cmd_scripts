#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

 find `pwd` -name "*lattice.silent" > sil20160711.list 
 find `pwd` -name "*lattice.res" > res20160711.list 
 wc -l res20160711.list 
 wc -l sil20160711.list 
 res20160711.list backup_res.sh
 mkdir backupres20160711
 sed -i -e "s/^/cp /" backup_res.sh 
 sed -i 's#$# ./backupres20160711; #' backup_res.sh 

cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" 20160706_uniqdonelist > res_C2_1_31
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" 20160706_uniqdonelist > res_C2_2_16
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" 20160706_uniqdonelist > res_C3_4_1
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" 20160706_uniqdonelist > res_C3_3_6
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" 20160706_uniqdonelist > res_C3_2_13
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" 20160706_uniqdonelist > res_C3_1_12

cp 20160706_uniqdonelist_C2 C2_sym.sh
cp 20160706_uniqdonelist_C3 C3_sym.sh

sed -i -e 's/^/cd /' *_sym.sh
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log#' C3_sym.sh
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log#' C2_sym.sh

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/290 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/43/10 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log