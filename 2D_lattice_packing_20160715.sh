#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
find `pwd` -name "*lattice.silent" > sil20160715.list;
#find `pwd` -name "*lattice.res" > res20160715.list;
cp sil20160715.list res20160715.list;
rsub res20160715.list;

sort sil20160711.list > sil20160711.sortedlist;
sort res20160711.list > res20160711.sortedlist;
sort sil20160715.list > sil20160715.sortedlist;
sort res20160715.list > res20160715.sortedlist;

#cat res20160715.sortedlist | uniq > res20160715.uniqsortedlist

comm -23 sil20160715.sortedlist sil20160711.sortedlist > sil20160715only.sortedlist;
comm -23 res20160715.sortedlist res20160711.sortedlist > res20160715only.sortedlist;

for i in `cat sil20160715only.sortedlist`;do dirname $i;done > sildir20160715only.sortedlist

wc -l res20160715.list 
wc -l sil20160715.list
wc -l sil20160715only.sortedlist
wc -l res20160715only.sortedlist
cp res20160715.list backup_res_2.sh
mkdir backupres20160715;
sed -i -e "s/^/cp /" backup_res_2.sh;
sed -i 's#$# ./backupres20160715; #' backup_res_2.sh ;
sh backup_res_2.sh;

#cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" sildir20160715only.sortedlist > res_C2_1_31_2.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" sildir20160715only.sortedlist > res_C2_2_16_2.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" sildir20160715only.sortedlist > res_C3_4_1_2.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" sildir20160715only.sortedlist > res_C3_3_6_2.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" sildir20160715only.sortedlist > res_C3_2_13_2.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" sildir20160715only.sortedlist > res_C3_1_12_2.sh;


#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/	;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i 's/B/A/g' $i;done

#grep -vwE "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/" res_C2_2_16.sh > res_C2_2_16.sh;

sed -i -e 's/^/cd /' res*_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_1_31_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_2_16_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_4.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_4_1_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_3.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_3_6_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_2_13_2.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_1_12_2.sh;

cat res_C3_1_12_2.sh res_C3_2_13_2.sh res_C3_3_6_2.sh res_C3_4_1_2.sh res_C2_1_31_2.sh res_C2_2_16_2.sh > make_res_2.sh

cp sildir20160715only.sortedlist packing1_2.run;
#rsub packing1.run;

sed -i -e 's/^/cd /' packing1_2.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1_2.run;
cat packing1_2.run | tr -s " " > packing2_2.run;
paste packing2_2.run sil20160715only.sortedlist > packing3_2.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing3_2.run;
paste packing3_2.run res20160715only.sortedlist > packing4_2.run
sed -i 's#$#;#' packing4_2.run;
cat packing4_2.run | tr -s " " > packing5_2.run;
rsub packing5_2.run;

#sudo pssu --create-set 2Dpacking;
cat packing5_2.run |psu --load --sql-set 2Dpacking;
psu --stat --sql-set 2Dpacking;
for i in `seq 5`;do qsub submit_packing_2 --W group_list=hyak-stf;done >JOB_IDs_2Dpacking_2;

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203 ;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent 	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.silent  -parser:script_vars resfile=	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.res


#cd <done_list>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.silent -parser:script_vars resfile=HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.res
