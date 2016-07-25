#~/scripts/merge_silent.pl NPC1_native_receptor_positive_control_A_NPC1_native_receptor_positive_control_B_patchdock_split_0*.out > merge_all.silent
# modified from Zibo Chen's 2_get_pdb_from_silent.sh

pwd
mv local*all.out local.silent.out
grep SCORE: *all.out | awk '{print $28,$20,$1,$NF}' | sed 's/:SCORE://g' | sort -k2n > rms_Isc.sc
grep SCORE: *all.out | awk '{print $28,$2,$1,$NF}' | sed 's/:SCORE://g' | sort -k2n > rms_score.sc
grep SCORE: local.silent.out | awk '{print $28,$20,$1,$NF}' | sed 's/:SCORE://g' | sort -k2n > local_rms_Isc.sc
grep SCORE: local.silent.out | awk '{print $28,$2,$1,$NF}' | sed 's/:SCORE://g' | sort -k2n > local_rms_score.sc

#/bin/rm -f 2_get_pdb_from_silent.joblist
#head -20 rms_Isc.sc | awk '{print "/work/shilei/git_rosetta/Rosetta/main/source/bin/read_score_jump_silent_repack.default.linuxgccrelease -database /work/shilei/git_rosetta/Rosetta/main/database/ -s ../NPC1_native_receptor_positive_control_A.pdb_NPC1_native_receptor_positive_control_B.pdb_fakenative.pdb -in:file:silent",$3," -in:file:silent_struct_type score_jump -in:file:tags",$4,"out::prefix",NR"_rms_"$1"_Isc_"$2"_"}' >>  2_get_pdb_from_silent.joblist

#tags=`grep SCORE: merge_all.silent | awk '{print $20,$22,$NF}' | sort -k 2,2n | head -20 | awk '{print $NF}'`
#/bin/rm -f 2_get_pdb_from_silent.joblist
#for i in $tags
#do 
#	echo "/work/shilei/git_rosetta/Rosetta/main/source/bin/read_score_jump_silent_repack.default.linuxgccrelease -database /work/shilei/git_rosetta/Rosetta/main/database/ -s ../NPC1_native_receptor_positive_control_A.pdb_NPC1_native_receptor_positive_control_B.pdb_fakenative.pdb -in:file:silent merge_all.silent -in:file:silent_struct_type score_jump -in:file:tags $i" >> 2_get_pdb_from_silent.joblist
#done

#/work/shilei/git_rosetta/Rosetta/main/source/bin/read_score_jump_silent_repack.default.linuxgccrelease -database /work/shilei/git_rosetta/Rosetta/main/database/ -s ../NPC1_native_receptor_positive_control_A.pdb_NPC1_native_receptor_positive_control_B.pdb_fakenative.pdb -in:file:silent merge_all.silent -in:file:silent_struct_type score_jump -in:file:tags NPC100254_0000024_0r_positive_control_A_NPC1_native_receptor_positive_control_B_patchdock_split_02_00339_49429 
