#!/usr/bin/env python
# modified from Zibo Chen's copy_results_from_boinc.sh

import os
import shutil
import glob
import bz2
import tarfile
from subprocess import call

def exec_( dry_run ):
	def execute( cmd ):
		if dry_run:
			print cmd
		else:
			os.system( cmd )
	return execute

execute = exec_( False )

pwd=os.getcwd()
print pwd
f = open('boinc.dat','r')
surfix = f.read(2)
for line in f:
	boinc=line.split( )

destination="./"
for file in glob.glob("/net/BOINC/results/" + surfix + boinc[0] + "/*" + boinc[1] + "*.all.out.bz2"):
	shutil.copy(file,destination)
for file in glob.glob("/net/BOINC/results/local_" + surfix + "/*" + boinc[1] + "*.all.out.bz2"):
	shutil.copy(file,destination)

for file in  glob.glob("*.bz2"):
	name=os.path.splitext(file)[0]
	if os.path.isfile(name):
		os.remove(name)
	execute('bzcat ' + file + ' > ' + name )
	os.remove(file)
