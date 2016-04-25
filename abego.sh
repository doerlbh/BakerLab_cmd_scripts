#Check abego type of helical bundles

#(first source Alex's work environment)
source ~fordas/virtualenvs/close_structure_prototype/bin/activate

#(prints out abego type in strings) 
python /work/oberdogu/scripts/dump_abego_sequence.py *.pdb 

#(will dump out a png with fragment quality plots)
python /work/oberdogu/scripts/sequence_based_backbone_compatibility.py  *.pdb 