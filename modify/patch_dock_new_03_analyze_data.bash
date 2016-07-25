#!/bin/bash

mkdir results_boinc
mkdir results_boinc/PNG
for i in `cat boinc_job_names.list | awk '{print $1 "_xxxabcxxx_" $2 "_xxxdefxxx_" $3}'`; 
do 
  oriname=`echo ${i} | sed -r 's/_xxxabcxxx_/ /' | sed -r 's/_xxxdefxxx_/ /' | awk '{print $1}'`
  boincname=`echo ${i} | sed -r 's/_xxxabcxxx_/ /' | sed -r 's/_xxxdefxxx_/ /' | awk '{print $2}'`
  batchid=`echo ${i} | sed -r 's/_xxxabcxxx_/ /' | sed -r 's/_xxxdefxxx_/ /' | awk '{print $3}'`
  out_global_name1="results_boinc/${oriname}_globalDocking__rmsd_vs_totsc.dat"
  out_global_name2="results_boinc/${oriname}_globalDocking__rmsd_vs_Isc.dat"
  out_local_name1="results_boinc/${oriname}_localDocking__rmsd_vs_totsc.dat"
  out_local_name2="results_boinc/${oriname}_localDocking__rmsd_vs_Isc.dat"
  plot_out_name1="results_boinc/PNG/${oriname}_Docking__rmsd_vs_totsc.png"
  plot_out_name2="results_boinc/PNG/${oriname}_Docking__rmsd_vs_Isc.png"
#  bzcat /net/BOINC/results/${boincname:0:8}/${boincname}*_globalDocking_*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $28 " " $2}' > ${out_global_name1}; 
#  bzcat /net/BOINC/results/${boincname:0:8}/${boincname}*_globalDocking_*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $28 " " $20}' > ${out_global_name2}; 
#  bzcat /net/BOINC/results/${boincname:0:8}/${boincname}*_localDocking_*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $28 " " $2}'  > ${out_local_name1}; 
#  bzcat /net/BOINC/results/${boincname:0:8}/${boincname}*_localDocking_*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $28 " " $20}'  > ${out_local_name2}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $31 " " $2}' > ${out_global_name1}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $31 " " $20}' > ${out_global_name2}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $31 " " $2}'  > ${out_local_name1}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $31 " " $20}'  > ${out_local_name2}; 
  gnuplot -e "set term png; \
	set output '${plot_out_name1}'; \
	stats '${out_local_name1}' using 2; \
	minum_local=STATS_min-5; \
	stats '${out_global_name1}' using 2; \
	avg_global=STATS_mean+5; \
	set yrange[minum_local:avg_global]; \
	set xrange [-0.1:80];  \
	plot './${out_local_name1}' w points pt 5 ps .2, './${out_global_name1}' w points pt 3 ps .2 "
  gnuplot -e "set term png; \
	set output '${plot_out_name2}'; \
	stats '${out_local_name2}' using 2; \
	minum_local=STATS_min-5; \
	stats '${out_global_name2}' using 2; \
	avg_global=STATS_mean+5; \
	set yrange[minum_local:avg_global]; \
	set xrange [-0.1:80];  \

	plot './${out_local_name2}' w points pt 5 ps .2, './${out_global_name2}' w points pt 3 ps .2 "
done