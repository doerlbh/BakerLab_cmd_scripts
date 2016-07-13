#given an adjacent.pdb and full_lattice.pdb, extract adj from full_lattice
#$1 is adjacent.pdb
#$2 is full_lattice.pdb
#$3 is number of residues per helix turn helix 

/gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/mican $1 $2 -o $1.output
grep "^ATOM..* A " $1.output > "A_$1.output"
grep "^ATOM..* B " $1.output > "B_$1.output"
#figure our chain A
	grep " CA " A_$1.output >A_$1.output.loop.list
	grep " CA " $2 >$2.full.list
	python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking/get_alignment.py A_$1.output.loop.list $2.full.list $3 1
	# for i in `cat small_truc.txt `;do grep -e $i large_truc.txt|awk '{print $1}';done >temp1
	# for i in `cat small_round.txt `;do grep -e $i large_round.txt|awk '{print $1}';done >temp2
	# cat temp1 temp2 |sort |uniq > temp
	for i in `cat temp`;do if [ ${#i} -lt "4" ];then grep -e " $i   " $2;else grep "$i   " $2;fi;done >A-$2.ectracted_adjacent.pdb
	cat A-$2.ectracted_adjacent.pdb | awk -F, -v OFS= '{print substr($0,1,21),"A",substr($0,23)}' >A1
#figure out chain B
	grep " CA " B_$1.output >B_$1.output.loop.list
	grep " CA " $2 >$2.full.list
	python /gscratch/stf/sunnylin/160624_flatland_finer_sampling/extract4docking//get_alignment.py B_$1.output.loop.list $2.full.list $3 4
	# for i in `cat small_truc.txt `;do grep -e $i large_truc.txt|awk '{print $1}';done >temp1
	# for i in `cat small_round.txt `;do grep -e $i large_round.txt|awk '{print $1}';done >temp2
	# cat temp1 temp2 |sort |uniq > temp
	for i in `cat temp`;do if [ ${#i} -lt "4" ];then grep -e " $i   " $2;else grep "$i   " $2;fi;done >B-$2.ectracted_adjacent.pdb
	cat B-$2.ectracted_adjacent.pdb | awk -F, -v OFS= '{print substr($0,1,21),"B",substr($0,23)}' >B1
cat A1 B1 >$2.extracted_adjacent.pdb
rm *.list temp ?_$1.output A1 B1 ?-$2.ectracted_adjacent.pdb $1.output