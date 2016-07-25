#!/bin/bash

# Fetech top scoring docked models from forward docking.
# By Dave La (Wed Dec  2 21:32:56 PST 2015)

# Fetch top number of designs based on score and rmsd
if [ -z "$1" ]; then
   top_num=5;
else
   top_num=$1;
fi

# Make boinc results folder if step 3 (analyze results and make forward docking plots) was skipped
echo "Processing Scores for the Top ${top_num} Docked Models.";

mkdir -p results_boinc/
cd results_boinc/

for i in `cat ../boinc_job_names.list | awk '{print $1 "_xxxabcxxx_" $2}'`; 
do 
  oriname=`echo ${i/_xxxabcxxx_/ } | awk '{print $1}'`
  boincname=`echo ${i/_xxxabcxxx_/ } | awk '{print $2}'`

  out_global_name1="top${top_num}_${oriname}_globalDocking_totsc.dat"
  out_global_name2="top${top_num}_${oriname}_globalDocking_Isc.dat"
  # out_global_name3="top${top_num}_${oriname}_globalDocking_rmsd.dat"
  # out_global_name4="top${top_num}_${oriname}_globalDocking_irmsd.dat"
  # out_global_name5="top${top_num}_${oriname}_globalDocking_fnat.dat"

  out_local_name1="top${top_num}_${oriname}_localDocking_totsc.dat"
  out_local_name2="top${top_num}_${oriname}_localDocking_Isc.dat"
  # out_local_name3="top${top_num}_${oriname}_localDocking_rmsd.dat"
  # out_local_name4="top${top_num}_${oriname}_localDocking_irmsd.dat"
  # out_local_name5="top${top_num}_${oriname}_localDocking_fnat.dat"

  # Output data in order: pdb_name, rmsd, total_score, Isc (Isc)
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $36 " " $2}'  | sort -nk 2 | head -n ${top_num} > ${out_global_name1}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $36 " " $20}' | sort -nk 2 | head -n ${top_num} > ${out_global_name2}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $35 " " $30}' | sort -nk 2 | head -n ${top_num} > ${out_global_name3}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $35 " " $24}' | sort -nk 2 | head -n ${top_num} > ${out_global_name4}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $35 " " $22}' | sort -rnk 2 | head -n ${top_num} > ${out_global_name5}; 

  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $35 " " $2}' | sort -nk 2 | head -n ${top_num} > ${out_local_name1}; 
  bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $35 " " $20}' | sort -nk 2 | head -n ${top_num} > ${out_local_name2}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $34 " " $30}' | sort -nk 2 | head -n ${top_num} > ${out_local_name3}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $34 " " $24}' | sort -nk 2 | head -n ${top_num} > ${out_local_name4}; 
  # bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep ^SCORE | grep -v rms | awk '{print $34 " " $22}' | sort -rnk 2 | head -n ${top_num} > ${out_local_name5}; 


 # Get lists of top models according to multiple metrics
 rt_out_global_name1="rt_top${top_num}_${oriname}_globalDocking_totsc.dat"
 rt_out_global_name2="rt_top${top_num}_${oriname}_globalDocking_Isc.dat"
 # rt_out_global_name3="rt_top${top_num}_${oriname}_globalDocking_rmsd.dat"
 # rt_out_global_name4="rt_top${top_num}_${oriname}_globalDocking_irmsd.dat"
 # rt_out_global_name5="rt_top${top_num}_${oriname}_globalDocking_fnat.dat"

 rt_out_local_name1="rt_top${top_num}_${oriname}_localDocking_totsc.dat"
 rt_out_local_name2="rt_top${top_num}_${oriname}_localDocking_Isc.dat"
 # rt_out_local_name3="rt_top${top_num}_${oriname}_localDocking_rmsd.dat"
 # rt_out_local_name4="rt_top${top_num}_${oriname}_localDocking_irmsd.dat"
 # rt_out_local_name5="rt_top${top_num}_${oriname}_localDocking_fnat.dat"

# Make new header files
 bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | head -n 1 > global_header.txt;
 echo "SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13       rama      omega     fa_dun    p_aa_pp        ref    Isc    sasa    shape       Fnat       I_sc       Irms    cen_rms    interchain_contact    interchain_env    interchain_pair    interchain_vdw        rms    st_rmsd     maxsub       time    user_tag                                               description" >>global_header.txt;
# Yes, we use the globalDocking headers for the local docking RT results because the localdocking header are not complete and don't work for PDB extraction later.
 bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | head -n 1 > local_header.txt;
 echo "SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13       rama      omega     fa_dun    p_aa_pp        ref    Isc    sasa    shape       Fnat       I_sc       Irms    cen_rms    interchain_contact    interchain_env    interchain_pair    interchain_vdw        rms    st_rmsd     maxsub       time    user_tag                                               description" >>local_header.txt;

# Fetch RT (Rotation and Translation) Operations for only the Top Models

 # Overwrite if it exists (for update runs)
 for i in `seq 1 ${top_num}`; do head -n 2 global_header.txt > ${i}_${rt_out_global_name1}; done;
 for i in `seq 1 ${top_num}`; do head -n 2 global_header.txt > ${i}_${rt_out_global_name2}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 global_header.txt > ${i}_${rt_out_global_name3}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 global_header.txt > ${i}_${rt_out_global_name4}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 global_header.txt > ${i}_${rt_out_global_name5}; done;

 for i in `seq 1 ${top_num}`; do head -n 2 local_header.txt > ${i}_${rt_out_local_name1}; done;
 for i in `seq 1 ${top_num}`; do head -n 2 local_header.txt > ${i}_${rt_out_local_name2}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 local_header.txt > ${i}_${rt_out_local_name3}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 local_header.txt > ${i}_${rt_out_local_name4}; done;
 # for i in `seq 1 ${top_num}`; do head -n 2 local_header.txt > ${i}_${rt_out_local_name5}; done;

 count=0;
 for i in `awk '{print $1}' ${out_global_name1}`; do ((count++)); echo "SCORE:  -503.001  -1457.542    174.698    800.261           3.808   -145.381        1.755        -99.656        -82.842        -31.759     -37.740       -2.178     -3.378     35.350    397.427    -52.891     -2.934 -17.665 1751.616    0.535      0.927    -17.665      0.041      1.422               -20.000           -31.962              2.506             0.165      0.028      0.000    390.000     88.000 $i">>${count}_${rt_out_global_name1};bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep -e $i |grep -v SCORE: >> ${count}_${rt_out_global_name1}; done;
 count=0;
 for i in `awk '{print $1}' ${out_global_name2}`; do ((count++)); echo "SCORE:  -503.001  -1457.542    174.698    800.261           3.808   -145.381        1.755        -99.656        -82.842        -31.759     -37.740       -2.178     -3.378     35.350    397.427    -52.891     -2.934 -17.665 1751.616    0.535      0.927    -17.665      0.041      1.422               -20.000           -31.962              2.506             0.165      0.028      0.000    390.000     88.000 $i">>${count}_${rt_out_global_name2};bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep -e $i |grep -v SCORE: >> ${count}_${rt_out_global_name2}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_global_name3}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_global_name3}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_global_name4}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_global_name4}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_global_name5}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_globalDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_global_name5}; done;

 count=0;
 for i in `awk '{print $1}' ${out_local_name1}`; do ((count++)); echo "SCORE:  -503.001  -1457.542    174.698    800.261           3.808   -145.381        1.755        -99.656        -82.842        -31.759     -37.740       -2.178     -3.378     35.350    397.427    -52.891     -2.934 -17.665 1751.616    0.535      0.927    -17.665      0.041      1.422               -20.000           -31.962              2.506             0.165      0.028      0.000    390.000     88.000 $i">>${count}_${rt_out_local_name1};bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep -e $i |grep -v SCORE: >> ${count}_${rt_out_local_name1}; done;
 count=0;
 for i in `awk '{print $1}' ${out_local_name2}`; do ((count++)); echo "SCORE:  -503.001  -1457.542    174.698    800.261           3.808   -145.381        1.755        -99.656        -82.842        -31.759     -37.740       -2.178     -3.378     35.350    397.427    -52.891     -2.934 -17.665 1751.616    0.535      0.927    -17.665      0.041      1.422               -20.000           -31.962              2.506             0.165      0.028      0.000    390.000     88.000 $i">>${count}_${rt_out_local_name2};bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep -e $i |grep -v SCORE: >> ${count}_${rt_out_local_name2}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_local_name3}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_local_name3}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_local_name4}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_local_name4}; done;
 # count=0;
 # for i in `awk '{print $1}' ${out_local_name5}`; do ((count++)); bzcat /net/BOINC/results/${boincname:0:8}/*${oriname}*_localDocking_*${batchid}*all.out.bz2 | grep $i >> ${count}_${rt_out_local_name5}; done;

 mkdir -p dock_global/
 cd dock_global/

 echo;
 echo "Extracting Global Docking Models.";

 count=0;
 for i in `awk '{print $1}' ../${out_global_name1}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_global_name1} $i $oriname-${count}_totsc_global_dock_ >> global.job; done;
 count=0;
 for i in `awk '{print $1}' ../${out_global_name2}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_global_name2} $i $oriname-${count}_Isc_global_dock_ >> global.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_global_name3}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_global_name3} $i ${count}_rmsd_global_dock_ >> global.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_global_name4}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_global_name4} $i ${count}_irmsd_global_dock_ >> global.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_global_name5}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_global_name5} $i ${count}_fnat_global_dock_ >> global.job; done;

 cat global.job | /work/davela/bin/parallel;
 rm global.job

 cd ..

 mkdir -p dock_local/
 cd dock_local/

 echo;
 echo "Extracting Local Docking Models.";

 count=0;
 for i in `awk '{print $1}' ../${out_local_name1}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_local_name1} $i $oriname-${count}_totsc_local_dock_ >> local.job; done;
 count=0;
 for i in `awk '{print $1}' ../${out_local_name2}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_local_name2} $i $oriname-${count}_Isc_local_dock_ >> local.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_local_name3}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_local_name3} $i ${count}_rmsd_local_dock_ >> local.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_local_name4}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_local_name4} $i ${count}_irmsd_local_dock_ >> local.job; done;
 # count=0;
 # for i in `awk '{print $1}' ../${out_local_name5}`; do ((count++)); echo /work/davela/bin/statics/read_score_jump_silent_repack/read_score_jump_silent.sh ../../$oriname ../${count}_${rt_out_local_name5} $i ${count}_fnat_local_dock_ >> local.job; done;


 cat local.job | /work/davela/bin/parallel;
 rm local.job

 cd ..

 done