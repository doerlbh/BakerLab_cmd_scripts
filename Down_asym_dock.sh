#!/bin/bash
# Baihan Lin, July 2015
# Baker Lab




for i in *asymdock;do
	cd $i
	python /work/sunnylin/scripts/boinc/1_copy_results_from_boinc.py
	sh /work/sunnylin/scripts/boinc/2_get_pdb_from_silent.sh
	gnuplot <<\EOF
		set xrange [0:20]
		set yrange [:-300]
		set terminal png
		set output 'rms_Isc.png'
		plot 'rms_Isc.sc' u 1:2 w p
		set terminal png
		set output 'rms_score.png'
		set yrange [:-300]
		plot 'rms_score.sc' u 1:2 w p
		set terminal png
		set output 'local_rms_Isc.png'
		set  yrange [:-300]
		plot 'local_rms_Isc.sc' u 1:2 w p
		set terminal png
		set output 'local_rms_score.png'
		set yrange [:-300]
		plot 'local_rms_score.sc' u 1:2 w p
EOF
	cd ../
done

for i in *pdb;do
	cd $i-asymdock;
	num = 
	string = A__$num_2016
	cp /net/BOINC/results/A__${string:0:8}/


	gnuplot <<\EOF
		set xrange [0:20]
		set terminal png
		set output $i_rms_sc.png
		plot 'all_plot.sc' u 2:31 w p
		EOF
	cd ../
done