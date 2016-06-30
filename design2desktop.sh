#!/bin/bash

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/
find `pwd` -name "HBNet_*.pdb" > design_list_absolute_round_1
cp design_list_absolute_round_1 design_out.sh
mkdir HBNet_designs

sed -i -e 's/^/cp /' design_out.sh
sed -i 's#$# /gscratch/stf/sunnylin/160624_flatland_finer_sampling/HBNet_designs#' design_out.sh

sh design_out.sh
