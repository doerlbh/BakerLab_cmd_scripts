#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;

#find `pwd` -name "*lattice.silent" > sil20160711.list 
#find `pwd` -name "*lattice.res" > res20160711.list 
#for i in `cat sil20160711.list`;do dirname $i;done > sildir20160711.list

#wc -l res20160711.list 
#wc -l sil20160711.list 
#res20160711.list backup_res.sh
#mkdir backupres20160711
#sed -i -e "s/^/cp /" backup_res.sh 
#sed -i 's#$# ./backupres20160711; #' backup_res.sh 

#cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_donelist | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/20160706_uniqdonelist

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" 20160706_uniqdonelist > extd_6_ZC31_76.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" 20160706_uniqdonelist > extd_5_ZC16_75.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" 20160706_uniqdonelist > extd_4_5L6HC3_1_85.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" 20160706_uniqdonelist > extd_3_2L6HC3_6_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" 20160706_uniqdonelist > extd_2_2L6HC3_13_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" 20160706_uniqdonelist > extd_1_2L6HC3_12_74.sh;

# cd <dir>;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* <monomer_length>;done


sed -i -e 's/^/cd /' extd*.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 76;done#' extd_6_ZC31_76.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done#' extd_5_ZC16_75.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 85;done#' extd_4_5L6HC3_1_85.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_3_2L6HC3_6_74.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_2_2L6HC3_13_74.sh;
sed -i 's#$#;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_1_2L6HC3_12_74.sh;

cat extd_6_ZC31_76.sh extd_5_ZC16_75.sh extd_4_5L6HC3_1_85.sh extd_3_2L6HC3_6_74.sh extd_2_2L6HC3_13_74.sh extd_1_2L6HC3_12_74.sh > extractdone.run;

#testing
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/204;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done

#submit jobs to parallel
cat extractdone.run | parallel -j16 &



sed -i -e 's/^/cd /' packing1.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ @/gscratch/baker/zibochen/scripts/xml_and_flags/flatland_final_packing.flags -in:file:silent #' packing1.run;
cat packing1.run | tr -s " " > packing2.run;
paste packing2.run sil20160711.list > packing3.run;
sed -i 's#$#  -parser:script_vars resfile=#' packing3.run;
paste packing3.run res20160711.list > packing4.run
sed -i 's#$#;#' packing4.run;
cat packing4.run | tr -s " " > packing5.run;




sudo pssu --create-set 2Dpacking;
cat packing5.run |psu --load --sql-set 2Dpacking;
psu --stat --sql-set 2Dpacking;
for i in `seq 60`;do qsub submit_packing -q bf;done >JOB_IDs_2Dpacking;

 # cd <dir>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *extracted*pdb -renumber_pdb 1 ;
