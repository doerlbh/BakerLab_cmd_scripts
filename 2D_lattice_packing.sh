#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

 find `pwd` -name "*lattice.silent" > sil20160711.list 
 find `pwd` -name "*lattice.res" > res20160711.list 
for i in `cat sil20160711.list`;do dirname $i;done > sildir20160711.list

 wc -l res20160711.list 
 wc -l sil20160711.list 
 res20160711.list backup_res.sh
 mkdir backupres20160711
 sed -i -e "s/^/cp /" backup_res.sh 
 sed -i 's#$# ./backupres20160711; #' backup_res.sh 

cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" 20160706_uniqdonelist > res_C2_1_31.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" 20160706_uniqdonelist > res_C2_2_16.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" 20160706_uniqdonelist > res_C3_4_1.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" 20160706_uniqdonelist > res_C3_3_6.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" 20160706_uniqdonelist > res_C3_2_13.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" 20160706_uniqdonelist > res_C3_1_12.sh;


#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/	;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i 's/B/A/g' $i;done

#grep -vwE "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/" res_C2_2_16.sh > res_C2_2_16.sh;

sed -i -e 's/^/cd /' res*.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_1_31.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C2_2_16.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_4.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_4_1.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_3.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_3_6.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_2_13.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c3_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_C3_1_12.sh;

cat res_C3_1_12.sh res_C3_2_13.sh res_C3_3_6.sh res_C3_4_1.sh res_C2_1_31.sh res_C2_2_16.sh > make_res.sh

cp sildir20160711.list packing1.run;
rsub packing1.run;

sed -i -e 's/^/cd /' packing1.run;
sed -i 's#$# ;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1.run;
paste packing1.run sil20160711.list > packing2.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing2.run;
paste packing2.run res20160711.list > packing3.run

sudo pssu --create-set 2Dpacking

 cat packing3.run |psu --load --sql-set 2Dpacking

 psu --stat --sql-set 2Dpacking
 
 for i in `seq 60`;do qsub submit_packing -q bf;done >JOB_IDs_2Dpacking

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203 ;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent 	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.silent  -parser:script_vars resfile=	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.res


#cd <done_list>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.silent -parser:script_vars resfile=HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.res
