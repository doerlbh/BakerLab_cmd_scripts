#!/usr/local/bin/python2.7
# pre: a list of pdb file names with parameters
# post: extract out parameters of protein design and reassign into new combo
# by Baihan Lin, June 2016

# read in the list and parse the parameters

from os import system,popen
import string
from sys import argv, stdout, exit
import math
#from math import sin,cos, sqrt, hypot
#import numpy as np
#import subprocess
#from numpy.core.umath_tests import inner1d
import os.path
#import itertools

path = '/Users/DoerLBH/Dropbox/git/BakerLab_cmd_scripts/pdb_extraction/'
lrawname = argv[1]
lname = lrawname[:-5]
lstr = ".list"
ostr = "_matrix.out"

f=open(path + lname + lstr,'r')
flist=f.readlines()
flist=list(set(flist))
f.close()

# sample finely around the parameters

clist = []
count = 0

for bb in flist:
    A = bb.split('_')[0]
    B = bb.split('_')[1]
    C = bb.split('_')[2]
    clist.insert(count, A+' '+B+' '+C+'\n')
    count+=1
    

# set range


# make combinations

  
# remove duplicates

clist = list(set(clist))

#print clist

# write into file
                         
f=open(path + lname + ostr,'w')
f.writelines(clist)
f.close()

raw_input("Press<enter>")

