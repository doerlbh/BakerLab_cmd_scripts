#!/usr/local/bin/python2.7
#get the alignment regions for TMalign of heptads
from sys import argv
import re

def truncate(f, n):
    '''Truncates/pads a float f to n decimal places without rounding'''
    s = '{}'.format(f)
    if 'e' in s or 'E' in s:
        return '{0:.{1}f}'.format(f, n)
    i, p, d = s.partition('.')
    return '.'.join([i, (d+'0'*n)[:n]])

def cal_dist_xyz(list1,list2):
	dist=0
	#calculates distance in 3D
	for i in range(3):
		dist+=(float(list1[i])-float(list2[i])) * (float(list1[i])-float(list2[i]))
	return dist ** (0.5)

small=argv[1]
large=argv[2]
length=int(argv[3])
starting_point=int(argv[4])
cn=3

small_truc={}
large_truc={}
all_ind=[]

with open(small) as template:
	for line in template:
		small_truc[line[22:26].replace(" ", "")]=[line[30:38], line[38:46], line[46:54]]
with open(large) as template:
	for line in template:
		large_truc[line[22:26].replace(" ", "")]=[line[30:38], line[38:46], line[46:54]]
#print large_truc
for i in [1+length*(starting_point-1),length+1+length*(starting_point-1),length*2+1+length*(starting_point-1)]: #,length*3+1,length*4+1,length*5+1
	ref=10
	closest_ind=0
	for j in large_truc.keys():
		#print small_truc[str(i)],large_truc[j]
		temp=cal_dist_xyz(small_truc[str(i)],large_truc[j])
		if temp<ref:
			ref=temp
			closest_ind=j
	all_ind.append(closest_ind)
f = open("temp", 'w')
for i in all_ind:
	for j in range(length):
		f.write(str(int(i)+j)+"\n")
# for i in small_truc:
# 	for j in range(len(i)):
# 		i[j]=truncate(float(i[j]),1)
# for i in small_round:
# 	for j in range(len(i)):
# 		i[j]=round(float(i[j]),1)
# for i in large_truc:
# 	for j in range(1,len(i)):
# 		i[j]=truncate(float(i[j]),1)
# for i in large_round:
# 	for j in range(1,len(i)):
# 		i[j]=round(float(i[j]),1)
# f = open("large_truc.txt", 'w')
# for i in large_truc:
# 	f.write(i[0]+" ")
# 	for j in range(1,len(i)):
# 		f.write(str(i[j])+"+")
# 	f.write("\n")
# f = open("large_round.txt", 'w')
# for i in large_round:
# 	f.write(i[0]+" ")
# 	for j in range(1,len(i)):
# 		f.write(str(i[j])+"+")
# 	f.write("\n")
# f = open("small_truc.txt", 'w')
# for i in small_truc:
# 	for j in i:
# 		f.write(str(j)+"+")
# 	f.write("\n")
# f = open("small_round.txt", 'w')
# for i in small_round:
# 	for j in i:
# 		f.write(str(j)+"+")
# 	f.write("\n")
