#!/bin/bash
# Author: Baihan Lin
# Date: July 2016
# Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/
find `pwd` -name "HBNet_*.pdb" > design_list_absolute_round_1
cp design_list_absolute_round_1 design_out.sh
mkdir HBNet_designs

sed -i -e 's/^/cp /' design_out.sh
sed -i 's#$# /gscratch/stf/sunnylin/160624_flatland_finer_sampling/HBNet_designs#' design_out.sh

sh design_out.sh




cp pdb41_anasc20160722 outpdb41.sh

sed -i -e 's/^/cp /' outpdb41.sh
sed -i 's#$#* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722#' outpdb41.sh

sh outpdb41.sh

scp sunnylin@hyak.washington.edu:/gscratch/stf/sunnylin/160624_flatland_finer_sampling/C3_88_20160722/* .


cp /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/27/23/analysis_packed_HBNet_P321_P321_41.6_41.6_109.5-11.5_A_2L_6H_C3_12_xray_adjacent_0001_0005_designed_full_lattice.pdb_0001.pdb.extracted_adjacent_0001* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722
cp /gscratch/stf/sunnylin/160624_flatland_finer_sampling/1/1/63/146/analysis_packed_HBNet_P321_P321_41.2_41.2_116.5-15.5_A_2L_6H_C3_12_xray_adjacent_0001_0002_designed_full_lattice.pdb_0001.pdb.extracted_adjacent_0001* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722
cp /gscratch/stf/sunnylin/160624_flatland_finer_sampling/2/1/66/132/analysis_packed_HBNet_P321_P321_44.8_44.8_36.516_A_2L_6H_C3_13_xray_adjacent_0001_0002_designed_full_lattice.pdb_0001.pdb.extracted_adjacent_0001* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722
cp /gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/1/149/79/analysis_packed_HBNet_P321_P321_47.4_47.4_47-3_A_5L_6H_C3_1_scemal_adjacent_0001_0001_designed_full_lattice.pdb_0001.pdb.extracted_adjacent_0001* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722
cp /gscratch/stf/sunnylin/160624_flatland_finer_sampling/4/1/160/119/analysis_packed_HBNet_P321_P321_47.6_47.6_504.5_A_5L_6H_C3_1_scemal_adjacent_0001_0001_designed_full_lattice.pdb_0001.pdb.extracted_adjacent_0001* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb41_20160722


cp C3pdb C3Out.sh
mkdir C3_88_20160722;
sed -i -e 's/^/cp /' C3Out.sh;
sed -i 's#$#* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/C3_88_20160722#' C3Out.sh;
sh C3Out.sh;



rsub outpdb35.sh
sed -i -e 's/^/cp /' outpdb35.sh
sed -i 's#$#* /gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb35_20160803#' outpdb35.sh
sh outpdb35.sh

#scp sunnylin@hyak.washington.edu:/gscratch/stf/sunnylin/160624_flatland_finer_sampling/pdb35_20160803/ .
