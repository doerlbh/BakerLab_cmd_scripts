#!/bin/bash
#Author: Baihan Lin
#Date: August 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
find `pwd` -name "*lattice.silent" > sil20160801.list;
#find `pwd` -name "*lattice.res" > res20160801.list;
cp sil20160801.list res20160801.list;
sed -i 's/silent/res/g' res20160801.list;

sort /gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/sil20160720.list > sil20160720.sortedlist;
sort /gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/res20160720.list > res20160720.sortedlist;
sort sil20160801.list > sil20160801.sortedlist;
sort res20160801.list > res20160801.sortedlist;

cp sil20160715.sortedlist sil20160715.list
cp res20160715.sortedlist res20160715.list
cp sil20160711.sortedlist sil20160711.list
cp res20160711.sortedlist res20160711.list
sort sil20160715.list > sil20160715.sortedlist;
sort res20160715.list > res20160715.sortedlist;
sort sil20160711.list > sil20160711.sortedlist;
sort res20160711.list > res20160711.sortedlist;


#cat res20160801.sortedlist | uniq > res20160801.uniqsortedlist

comm -23 sil20160801.sortedlist sil20160720.sortedlist > sil20160801only.sortedlist;
comm -23 res20160801.sortedlist res20160720.sortedlist > res20160801only.sortedlist;
comm -23 sil20160801.sortedlist sil20160715.sortedlist > sil20160801only.sortedlist;
comm -23 res20160801.sortedlist res20160715.sortedlist > res20160801only.sortedlist;
comm -23 sil20160801.sortedlist sil20160711.sortedlist > sil20160801only.sortedlist;
comm -23 res20160801.sortedlist res20160711.sortedlist > res20160801only.sortedlist;


for i in `cat sil20160801only.sortedlist`;do dirname $i;done > sildir20160801only.sortedlist

wc -l res20160801.list 
wc -l sil20160801.list
wc -l sil20160801only.sortedlist
wc -l res20160801only.sortedlist
cp res20160801only.sortedlist backup_res_3.sh
mkdir backupres20160801;
sed -i -e "s/^/cp /" backup_res_3.sh;
sed -i 's#$# ./backupres20160801; #' backup_res_3.sh ;
sh backup_res_3.sh;

#cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" sildir20160801only.sortedlist > res_C2_1_31_3.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" sildir20160801only.sortedlist > res_C2_2_16_3.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" sildir20160801only.sortedlist > res_C3_4_1_3.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" sildir20160801only.sortedlist > res_C3_3_6_3.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" sildir20160801only.sortedlist > res_C3_2_13_3.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" sildir20160801only.sortedlist > res_C3_1_12_3.sh;


#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/	;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i 's/B/A/g' $i;done

#grep -vwE "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/" res_C2_2_16.sh > res_C2_2_16.sh;

sed -i -e 's/^/cd /' res*_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_1_31_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_2_16_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_4.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_4_1_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_3.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_3_6_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_2_13_3.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_1_12_3.sh;

cat res_C3_1_12_3.sh res_C3_2_13_3.sh res_C3_3_6_3.sh res_C3_4_1_3.sh res_C2_1_31_3.sh res_C2_2_16_3.sh > make_res_3.sh

sh make_res_3.sh

cp sildir20160801only.sortedlist packing1_2.run;
#rsub packing1.run;

sed -i -e 's/^/cd /' packing1_2.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1_2.run;
cat packing1_2.run | tr -s " " > packing2_2.run;
paste packing2_2.run sil20160801only.sortedlist > packing3_2.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing3_2.run;
paste packing3_2.run res20160801only.sortedlist > packing4_2.run
sed -i 's#$#;#' packing4_2.run;
cat packing4_2.run | tr -d '\011' > packing5_2.run;

#sudo pssu --create-set 2Dpacking;
cat packing5_2.run |psu --load --sql-set 2Dpacking;
psu --stat --sql-set 2Dpacking;

for i in `seq 5`;do qsub submit_packing_2 -W group_list=hyak-stf;done > JOB_IDs_2Dpacking_3;
for i in `seq 10`;do qsub submit_packing_baker -W group_list=hyak-baker;done >> JOB_IDs_2Dpacking_3;
for i in `seq 40`;do qsub submit_packing_2 -q bf;done > JOB_IDs_2Dpacking_3_bf

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203 ;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent 	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.silent  -parser:script_vars resfile=	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.res


#cd <done_list>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.silent -parser:script_vars resfile=HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.res

