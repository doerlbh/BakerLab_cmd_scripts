#!/bin/bash
# Baihan Lin, July 2015
# Baker Lab

cd /work/sunnylin/self_assembly_design/asym_docking_pdbs_20160722;

for i in *pdb;do
	num=${i%.*};
	cd $num-asymdock;
	folder=A__${num}_2016
	cp /net/BOINC/results/${folder:0:8}/*.sc.bz2 .;
	bzip2 -d *.bz2;
	cat *split_*.sc >> $num_all_plot.sc;

	gnuplot <<\EOF
		set xrange [0:20]
		set terminal png
		set output $num_rms_sc.png
		plot $num_all_plot.sc u 2:31 w p
EOF
	cd ../
done
