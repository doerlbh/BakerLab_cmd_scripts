#!/bin/bash
#This is a personal 1min DASM script, not intended for others use. 
#If you are trying to use it, you are on your own.

work_root_dir=`pwd`
boinc_dir="${work_root_dir}/boinc_docking_jobs"
parallel_bin="/work/dadriano/PROGRAMS/parallel-20141022/bin/parallel -j 20 --no-notice --bar "

#Do not modify
#0.Add ctrl-c trap
control_c()
## run if user hits control-c
{
  /bin/echo -en "\n*** You pressed ctr-c. Exiting ***\n"
  exit $?
}
## trap keyboard interrupt (control-c)
trap control_c SIGINT

if [ $# != 2 ]
then 
	/bin/echo -e "\n"
	/bin/echo -e "Error: This program requires exactyly 2 arguments!: a PDB list and a job name" 
	exit 1
fi

if [ -d ${boinc_dir} ]
then
	/bin/echo -e "Error: The boinc directory \"${boinc_dir}\"alrready exist. Remove it first" 
	exit 1
fi
mkdir ${boinc_dir}

#Create temporary directory
tmp_dir_path=${work_root_dir}/tmp
if [ ! -d ${tmp_dir_path} ]
then
	mkdir ${tmp_dir_path}
fi

#Out commmands to a temporary file
parallel_job_list="${work_root_dir}/tmp/generate_dockings_job_list.parallel"
for basePDBpath in `cat ${1}`
do
	base_name=`basename ${basePDBpath}`
	base_name_hash=`echo ${basePDBpath} | md5sum | awk '{print $1}'`
#	this_job_dir="${boinc_dir}/${base_name}_boinc_${base_name_hash}"
	this_job_dir="${boinc_dir}/${base_name}_boinc_$2"
	pdb_original_path="${basePDBpath}"
	#pdbA_original_path="${basePDBpath}_chainA.pdb"
	#pdbB_original_path="${basePDBpath}_chainB.pdb"
	#pdbA_basename=`basename ${pdbA_original_path}`
	#pdbB_basename=`basename ${pdbB_original_path}`
	if [ -d ${this_job_dir} ]
	then
		/bin/echo -e "Error: The boinc directory ${base_name_hash} alrready exist. Remove it first" 
		exit 1
	fi
	echo -e "mkdir ${this_job_dir} &&  \
grep \"^ATOM\" ${pdb_original_path} | grep \" A \" > ${this_job_dir}/${base_name/%.pdb/_chainA.pdb} &&  \
grep \"^ATOM\" ${pdb_original_path} | grep \" B \" > ${this_job_dir}/${base_name/%.pdb/_chainB.pdb}  &&  \
cd ${this_job_dir}/ && \
bash /work/cxu7/scripts/daniel/1_run_patchdock_to_generate_approximate_orientations.bash ${base_name/%.pdb/_chainA.pdb} ${base_name/%.pdb/_chainB.pdb} &>> ./build_boinc_job.log &&  \
bash /work/cxu7/scripts/daniel/2_setup_global_local_docking_on_boinc_hyak_poorMan.bash ${base_name/%.pdb/_chainA.pdb} ${base_name/%.pdb/_chainB.pdb} $2_${base_name} &>> ./build_boinc_job.log "
done > ${parallel_job_list}

echo "Running jobs in parallel (Commandline: ${parallel_bin})"
echo "Be patient"
date
${parallel_bin} < ${parallel_job_list}
date
echo "All done. Be happy!"



