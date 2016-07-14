import fileinput
import sys
from sys import argv
def replaceAll(file,searchExp,replaceExp):
    for line in fileinput.input(file, inplace=1):
        if searchExp in line:
            line = line.replace(searchExp,replaceExp)
        sys.stdout.write(line)

infile=argv[1]
pattern=argv[2]
replaceAll(infile,"analysis",pattern+"/analysis")