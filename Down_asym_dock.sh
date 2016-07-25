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
	cat *split_*.sc >> ${num}_all_plot.sc;
	cp ${num}_all_plot.sc all_plot.sc
	gnuplot <<\EOF
		set xrange [0:20]
		set yrange [:-300]
		set terminal png
		set output 'rms_sc.png'
		plot 'all_plot.sc' u 31:2 w p
EOF
cp rms_sc.png ${num}_rms_sc.png
	cd ../
done


for i in *pdb;do
num=${i%.*};
cd $num-asymdock;
cp ${num}_all_plot.sc all_plot.sc
gnuplot <<\EOF
set xrange [0:20]
set yrange [:-300]
set terminal png
set output 'rms_sc.png'
plot 'all_plot.sc' u 31:2 w p
EOF
cp rms_sc.png ${num}_rms_sc.png
cd ../
done


num=20;
cd $num-asymdock;
folder=A__${num}_2016
cp /net/BOINC/results/${folder:0:8}/*.sc.bz2 .;
bzip2 -d *.bz2;
cat *split_*.sc >> ${num}_all_plot.sc;
cp ${num}_all_plot.sc all_plot.sc
gnuplot <<\EOF
set xrange [0:20]
set yrange [:-300]
set terminal png
set output 'rms_sc.png'
plot 'all_plot.sc' u 31:2 w p
EOF
cp rms_sc.png ${num}_rms_sc.png
cd ../



for i in *pdb;do
num=${i%.*};
cd $num-asymdock;
cp ${num}_all_plot.sc all_plot.sc
gnuplot <<\EOF
set xrange [0:20]
set yrange [:-300]
set terminal png
set output 'Irms_I_sc.png'
plot 'all_plot.sc' u 25:24 w p
EOF
cp rms_sc.png ${num}_rms_sc.png
cd ../
done