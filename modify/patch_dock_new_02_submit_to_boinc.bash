#!/bin.bash
basedir=`pwd`; 
boinc_docks_dir="boinc_docking_jobs"

if [ $# != 1 ]
then 
	/bin/echo -e "\n"
	/bin/echo -e "Error: This program requires exactyly 1 arguments!: a job name used for 01_generate_dockings.bash" 
	exit 1
fi

for i in `find ${basedir} -maxdepth 2 -type d -name "*_boinc_*"`; 
do 
   cd ${i}; boincfile=`find ./ -name "*.boinc"`; 
   boinc_submit ${boincfile} &> boinc_submit.log; 
   boinc_submit_file=`find ./ -name "boinc_submit.log"`;
   batchid=$(cat ${boinc_submit_file} | sed -n '4p' | awk '{ print $NF }' | sed -r 's/\.//')
   basename=$(ls -d ${i} | sed 's/^.*'${boinc_docks_dir}'\///g' | sed 's/_boinc_/ /g' | awk -vjob_name=_$1 '{print $1 "\t" $2 job_name}')
   echo $basename $batchid
done > boinc_job_names.list 
cd ${basedir}

#ls -d ${boinc_docks_dir}/*_boinc_*  | sed 's/^'${boinc_docks_dir}'\///g' | sed 's/_boinc_/ /g' | awk -vjob_name=_$1 '{print $1 "\t" $2 job_name}' > boinc_job_names_test.list 
