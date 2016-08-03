#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;

now=$(date +"%Y%m%d")

cp sildir20160801only.sortedlist $now.dirlist
for i in `cat res20160711.sortedlist`;do dirname $i;done >> $now.dirlist
for i in `cat res20160715.sortedlist`;do dirname $i;done >> $now.dirlist

for j in `cat $now.dirlist`; do
	cd $j;
	find `pwd` -name "packed*.pdb" >> /gscratch/stf/sunnylin/160624_flatland_finer_sampling/packed$now.list;
	cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
done

for i in `cat packed$now.list`;do dirname $i;done > packeddir$now.list;
cat packeddir$now.list | uniq -d > packdiruniq$now.list;

cp packdiruniq$now.list analyreplace$now.run;

grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/" packdiruniq$now.list > extd_6_ZC31_76.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/" packdiruniq$now.list > extd_5_ZC16_75.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/" packdiruniq$now.list > extd_4_5L6HC3_1_85.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/3/" packdiruniq$now.list > extd_3_2L6HC3_6_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/" packdiruniq$now.list > extd_2_2L6HC3_13_74.sh;
grep "/gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/" packdiruniq$now.list > extd_1_2L6HC3_12_74.sh;

# cd <dir>;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* <monomer_length>;done


sed -i -e 's/^/cd /' extd*.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C2.sh $i packed_${i/.pdb/}*designed_full_lattice* 76;done#' extd_6_ZC31_76.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C2.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done#' extd_5_ZC16_75.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C3.sh $i packed_${i/.pdb/}*designed_full_lattice* 85;done#' extd_4_5L6HC3_1_85.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C3.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_3_2L6HC3_6_74.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C3.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_2_2L6HC3_13_74.sh;
sed -i 's#$#; rm *pdb_1_0001.pdb;rm *extracted*.pdb;rm analysis_score.sc; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj_C3.sh $i packed_${i/.pdb/}*designed_full_lattice* 74;done#' extd_1_2L6HC3_12_74.sh;

cat extd_6_ZC31_76.sh extd_5_ZC16_75.sh extd_4_5L6HC3_1_85.sh extd_3_2L6HC3_6_74.sh extd_2_2L6HC3_13_74.sh extd_1_2L6HC3_12_74.sh > extractdone$now.run;

#testing
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/204;for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 75;done

#submit jobs to parallel
cat extractdone$now.run | parallel -j16 &;

 # cd <dir>;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *extracted*pdb -renumber_pdb 1;

sed -i -e 's/^/cd /' analyreplace$now.run;
sed -i 's#$#;/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *extracted*pdb -renumber_pdb 1;python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/replace.py analysis_score.sc `pwd`;#' analyreplace$now.run;

cat analyreplace$now.run | parallel -j16 &

#cd <dir>;python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/replace.py analysis_score.sc `pwd`;
# cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/5/1/89/291;python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/replace.py analysis_score.sc `pwd`;

#sed -i -e 's/^/cd /' replace.run;
#sed -i 's#$#;python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/replace.py analysis_score.sc `pwd`;#' replace.run;

#cat replace.run | parallel -j16 &

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
touch anasc$now.txt;
find `pwd` -name "analysis_score.sc" > analysislist$now;
cp analysislist$now excelout$now.sh;
sed -i -e 's/^/cat /' excelout$now.sh;
sed -i 's#$# >> anasc$now.txt;#' excelout$now.sh;
sh excelout$now.sh;

#in computer
#scp sunnylin@hyak.washington.edu:/gscratch/stf/sunnylin/160624_flatland_finer_sampling/anasc20160714.txt .;




# test

#cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/6/1/26/122; rm "*_1_0001.pdb"; rm "*extract*.pdb"; for i in HBNet*pdb;do sh /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_adj.sh $i packed_${i/.pdb/}*designed_full_lattice* 76;done






