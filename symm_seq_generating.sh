#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab



cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160715_uniqdonelist;

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" 20160715_uniqdonelist > 20160715_uniqdonelist_C2;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" 20160715_uniqdonelist >> 20160715_uniqdonelist_C2;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" 20160715_uniqdonelist > 20160715_uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" 20160715_uniqdonelist >> 20160715_uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" 20160715_uniqdonelist >> 20160715_uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" 20160715_uniqdonelist >> 20160715_uniqdonelist_C3;

cp 20160715_uniqdonelist_C2 C2_sym_2.sh;
cp 20160715_uniqdonelist_C3 C3_sym_2.sh;

sed -i -e 's/^/cd /' *_sym_2.sh;
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log#' C3_sym_2.sh;
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log#' C2_sym_2.sh;

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/290 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/43/10 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log