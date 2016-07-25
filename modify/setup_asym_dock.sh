#!/bin/bash
# modified from Zibo Chen's setup_asym_dock.sh
#all you need is to put all pdbs (both chains in a single pdb) into current wd

rm cmd_list

#sh /work/sunnylin/self_assembly_design/get_A_and_B_separate.sh
sh /work/sunnylin/scripts/boinc/get_A_and_B_separate.sh

now=$(date +"%Y_%m_%d")
j=0
for i in B_*.pdb;do
	let j=j+1
	mkdir $j-asymdock
	mv $i $j-asymdock
	mv ${i//B_/A_} $j-asymdock
	cd $j-asymdock
	cp A_*pdb A__$j.pdb
	cp B_*pdb B__$j.pdb
	for k in ?__$j.pdb;do 
		mv $k ${k//.pdb/"_$now.pdb"}
	done
	#/work/zibochen/scripts/boinc/1_run_patchdock_to_generate_approximate_orientations A_*.pdb B_*.pdb
	#/work/zibochen/scripts/boinc/2_setup_global_local_docking_on_boinc_hyak A_*.pdb B_*.pdb
	#mv *.boinc run.docking.boinc
	cd ../
done
for i in *-asymdock;do
	echo "cd $i;/work/sunnylin/scripts/boinc/1_run_patchdock_to_generate_approximate_orientations A__*.pdb B__*.pdb;/work/sunnylin/scripts/boinc/2_setup_global_local_docking_on_boinc_hyak A__*.pdb B__*.pdb;mv *.boinc run.docking.boinc;cd ../;" >>cmd_list
done
/work/sunnylin/bin/nhp.sh 20 cmd_list
