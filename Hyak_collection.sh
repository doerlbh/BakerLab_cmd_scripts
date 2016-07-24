#!/bin/bash
#Author: Baihan Lin
#Lab: Baker Lab

 sudo pssu --create-set symmseq

 cat symm_seq.run |psu --load --sql-set symm_seq

 psu --stat --sql-set symmseq
 
 for i in `seq 10`;do qsub submit_design_12_core ;done >JOB_IDs_symmseq 

 for i in `seq 10`;do qsub submit_design_12_core -W group_list=hyak-baker;done >JOB_IDs_symmseq 

 for i in `seq 60`;do qsub submit_design -q bf;done >>JOB_IDs

 cat symm_seq.run | parallel -j16 &

 for i in `cat JOB_IDs_2Dpacking`;do qdel $i;done


showq -w group=hyak-baker
showq -w user=dalonso
showq -w class=batch:group=hyak-baker   -v
showq -w class=batch:group=hyak-baker
showq -w class=bf:group=hyak-baker
showq -w class=batch:group=hyak-baker
showq -i   <- priorities
showq -i -w class=batch:group=hyak-baker
showq -i -w qos=baker


msub -l walltime=04:00:00 -I  (interactive)
msub -q bf bf2.sh
checkjob Moab.58201
mjboctl -c 58201
mjboctl -c Moab.58201

#Individual quotas:

   mmlsquota -u sunnylin --block-size G gscratch | grep hyak-baker
   mmlsquota -u sunnylin gscratch:hyak-baker --block-size G
   mmlsquota -u sunnylin gscratch:hyak-baker --block-size Auto
   
mmlsquota -j hyak-baker collab
mmlsquota -j hyak-baker archive
mmlsquota -j hyak-baker gscratch --block-size G   
mmlsquota -j hyak-baker archive --block-size Auto    <--**new and useful**