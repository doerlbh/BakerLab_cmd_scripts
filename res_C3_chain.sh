#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
find `pwd` -name "*lattice.silent" > C3_res_20160720;
sed -i 's/silent/res/g' C3_res_20160720;
#sed -i '#/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/#d' C3_res_20160720;
#sed -i '#/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/#d' C3_res_20160720;

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" C3_res_20160720 > C3only_res_20160720;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" C3_res_20160720 >> C3only_res_20160720;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" C3_res_20160720 >> C3only_res_20160720;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" C3_res_20160720 >> C3only_res_20160720;
rm C3_res_20160720;
mv C3only_res_20160720 C3_res_20160720;

cp C3_res_20160720 C3_B2A_20160720.sh;
sed -i -e "s#^#sed -i \'s/B/A/g\' #" C3_B2A_20160720.sh;
sh C3_B2A_20160720.sh;

for i in `cat C3_res_20160720`;do dirname $i;done > C3_dirres_20160720
cp C3_res_20160720 C3_sil_20160720;
sed -i 's/res/silent/g' C3_sil_20160720;
cp C3_dirres_20160720 packing1_3.run;

# redo 2Dpacking

sed -i -e 's/^/cd /' packing1_3.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1_3.run;
cat packing1_3.run | tr -s " " > packing2_3.run;
paste packing2_3.run C3_sil_20160720 > packing3_3.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing3_3.run;
paste packing3_3.run C3_res_20160720 > packing4_3.run
sed -i 's#$#;#' packing4_3.run;
cat packing4_3.run | tr -d '\011' > packing5_3.run;
#rsub packing5_3.run;

#sudo pssu --create-set 2Dpacking;
cat packing5_3.run |psu --load --sql-set 2Dpacking;
psu --stat --sql-set 2Dpacking;
for i in `seq 5`;do qsub submit_packing_3 -W group_list=hyak-stf;done >JOB_IDs_2Dpacking_3;
