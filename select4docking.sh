#!/bin/bash
#Author: Baihan Lin
#Date: July 2016
#Lab: Baker Lab

cd /gscratch/stf/sunnylin/160624_flatland_finer_sampling/;
mkdir 2local;

cp selectedpdb4docking copy2local.sh;

sed -i -e 's/^/cp /' copy2local.sh;
sed -i 's#$#*.pdb 2local;#' copy2local.sh;

sh copy2local.sh;

scp -r sunnylin@hyak.washington.edu:/gscratch/stf/sunnylin/160624_flatland_finer_sampling/2local .;







