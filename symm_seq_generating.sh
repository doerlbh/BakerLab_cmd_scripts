#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab


now=$(date +"%Y%m%d")
cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/$now.uniqdonelist;

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" $now.uniqdonelist > $now.uniqdonelist_C2;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" $now.uniqdonelist >> $now.uniqdonelist_C2;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" $now.uniqdonelist > $now.uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" $now.uniqdonelist >> $now.uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" $now.uniqdonelist >> $now.uniqdonelist_C3;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" $now.uniqdonelist >> $now.uniqdonelist_C3;

cp $now.uniqdonelist_C2 C2_sym_3.sh;
cp $now.uniqdonelist_C3 C3_sym_3.sh;

sed -i -e 's/^/cd /' *_sym_3.sh;
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log#' C3_sym_3.sh;
sed -i 's#$# ;for i in HBNet*pdb;do /gscratch/stf/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log#' C2_sym_3.sh;

cat C2_sym_3.sh C3_sym_3.sh > symm_seq_3.run;

cat symm_seq_3.run | parallel -j16 &

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/290 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 2;done>symm_seq.log
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/43/10 ;for i in HBNet*pdb;do /gscratch/dimaio/zibochen/Rosetta/main/source/bin/symm_seq_gen_2D.default.linuxgccrelease -s $i *adjacent.pdb -cn 3;done>symm_seq.log