#!/bin/bash
# modified from Zibo Chen's plot_asym_dock.sh

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