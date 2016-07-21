#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/;
find `pwd` -name "*lattice.silent" > sil20160720.list;
#find `pwd` -name "*lattice.res" > res20160715.list;
cp sil20160720.list res20160720.list;
sed -i 's/silent/res/g' res20160720.list;
for i in `cat res20160720.list`;do dirname $i;done > dir20160720.list;

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
cp res20160715.list backup_res_3.sh
mkdir backupres20160720;
sed -i -e "s/^/cp /" backup_res_3.sh;
sed -i 's#$# ./backupres20160720; #' backup_res_3.sh ;
sh backup_res_3.sh;

#cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist
cp dir20160720.list res_6.sh

#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/	;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_2.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i 's/B/A/g' $i;done

#grep -vwE "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/212/" res_C2_2_16.sh > res_C2_2_16.sh;

sed -i -e 's/^/cd /' res_6.sh;
sed -i 's#$# ;for i in HBNet*res; do echo "">>$i;cat /gscratch/stf/zibochen/temp/c2_1.res>>$i;grep -v '^$' $i >temp;mv temp $i;sed -i \'s/B/A/g\' $i;done #' res_6.sh;

cp dir20160720.list packing1_2.run;
#rsub packing1.run;

sed -i -e 's/^/cd /' packing1_2.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1_2.run;
cat packing1_2.run | tr -s " " > packing2_2.run;
paste packing2_2.run sil20160720.list > packing3_2.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing3_2.run;
paste packing3_2.run res20160720.list > packing4_2.run
sed -i 's#$#;#' packing4_2.run;
cat packing4_2.run | tr -d '\011' > packing5_2.run;

#sudo pssu --create-set 2Dpacking;
cat packing5_2.run | parallel -j4

# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203 ;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent 	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.silent  -parser:script_vars resfile=	/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/203/HBNet_C211_C211_62.2_47.8_740_A_ZC16_adjacent_0001_0001_designed_full_lattice.res


#cd <done_list>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.silent -parser:script_vars resfile=HBNet_P321_P321_42_42_20_A_5L_6H_C3_1_scemal_adjacent_0001_0004_designed_full_lattice.res
