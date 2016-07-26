#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
mkdir modeltest
cd modeltest

scp *pdb sunnylin@hyak.washington.edu:/gscratch/stf/sunnylin/160624_flatland_finer_sampling/modeltest/


now=$(date +"%Y%m%d")

touch analysis$now;
sed -i 's#$#/gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/source/bin/rosetta_scripts.hdf5.linuxgccrelease -database /gscratch/baker/sboyken/AzoF_Rosetta/Rosetta/main/database/ -beta -out:prefix analysis_ -parser:protocol /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/analysis.xml -s *pdb -renumber_pdb 1;python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/replace.py analysis_score.sc `pwd`;#' analysis$now;

cat analysis$now | parallel -j16 &

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
