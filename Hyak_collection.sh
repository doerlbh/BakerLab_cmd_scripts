#!/bin/bash
#Author: Baihan Lin
#Lab: Baker Lab

sudo pssu --create-set symmseq

 psu --stat --sql-set symmseq
 
 for i in `seq 10`;do qsub submit_design_12_core ;done >JOB_IDs_symmseq 

 for i in `seq 10`;do qsub submit_design_12_core -W group_list=hyak-baker;done >JOB_IDs_symmseq 

 for i in `seq 10`;do qsub submit_design_12_core -q bf;done >JOB_IDs_symmseq