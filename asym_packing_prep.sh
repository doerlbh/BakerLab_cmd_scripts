#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;

find `pwd` -name "*extracted_adjacent.pdb" > clrjunk.sh;
sed -i -e 's/^/rm /' clrjunk.sh;
sh clrjunk.sh;


find `pwd` -name "packed*.pdb" > packed20160712.list;
for i in `cat packed20160712.list`;do dirname $i;done > packeddir20160712.list;
cat packeddir20160712.list | uniq -d > packdir20160712uniq.list;

#wc -l res20160711.list 
#wc -l sil20160711.list 
#res20160711.list backup_res.sh
#mkdir backupres20160711
#sed -i -e "s/^/cp /" backup_res.sh 
#sed -i 's#$# ./backupres20160711; #' backup_res.sh 

#cat /gscratch/stf/sunnylin/160624_flatland_finer_sampling/packed20160712.list | uniq -d > /gscratch/stf/sunnylin/160624_flatland_finer_sampling/packed20160712.list

cp packdir20160712uniq.list analydone.run;

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" packdir20160712uniq.list > extd_6_ZC31_76.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" packdir20160712uniq.list > extd_5_ZC16_75.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" packdir20160712uniq.list > extd_4_5L6HC3_1_85.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" packdir20160712uniq.list > extd_3_2L6HC3_6_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" packdir20160712uniq.list > extd_2_2L6HC3_13_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" packdir20160712uniq.list > extd_1_2L6HC3_12_74.sh;

# cd <dir>;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* <monomer_length>;done


sed -i -e 's/^/cd /' extd*.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 76;done#' extd_6_ZC31_76.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done#' extd_5_ZC16_75.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 85;done#' extd_4_5L6HC3_1_85.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_3_2L6HC3_6_74.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_2_2L6HC3_13_74.sh;
sed -i 's#$#; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_1_2L6HC3_12_74.sh;

cat extd_6_ZC31_76.sh extd_5_ZC16_75.sh extd_4_5L6HC3_1_85.sh extd_3_2L6HC3_6_74.sh extd_2_2L6HC3_13_74.sh extd_1_2L6HC3_12_74.sh > extractdone.run;

#testing
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/204;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done

#submit jobs to parallel
cat extractdone.run | parallel -j16 &;

 # cd <dir>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *extracted*pdb -renumber_pdb 1;

sed -i -e 's/^/cd /' analydone.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *extracted*pdb -renumber_pdb 1;#' analydone.run;

cat analydone.run | parallel -j16 &