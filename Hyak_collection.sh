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