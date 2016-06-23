# pre: a list of pdb file names with parameters
# post: extract out parameters of protein design and reassign into new combo
# by Baihan Lin, June 2016

# read in the list and parse the parameters

path = '/Users/DoerLBH/Dropbox/git/BakerLab_cmd_scripts/pdb_extraction/'
lname = raw_input("Enter pdb backbone name: ")
lstr = ".list"
ostr = ".out"

f=open(path + lname + lstr,'r')
flist=f.readlines()
flist=list(set(flist))
f.close()

first = flist[0]
Amax = Amin = int(first.split('_')[0])
Bmax = Bmin = int(first.split('_')[1])
Cmax = Cmin = int(first.split('_')[2])

# sample finely around the parameters

for bb in flist:
    A = int(bb.split('_')[0])
    B = int(bb.split('_')[1])
    C = int(bb.split('_')[2])
    if Amax < A:
        Amax = A
    elif Amin > A:
        Amin = A
    if Bmax < B:
        Bmax = B
    elif Bmin > B:
        Bmin = B
    if Cmax < C:
        Cmax = C
    elif Cmin > C:
        Cmin = C

# set range

Aran = [x*0.5 for x in range(2*(Amin-3), 2*(Amax+3)+1)]
Bran = [x*0.5 for x in range(2*(Bmin-3), 2*(Bmax+3)+1)]
Cran = range(Cmin-10, Cmax+11)
Cran = [x for x in Cran if x%2==0]

print Aran
print Bran
print Cran

# make combinations

clist = []
count = 0
for Ai in Aran:
    for Bi in Bran:
        for Ci in Cran:
            clist.insert(count,lname+'_'+str(Ai)+'_'+str(Bi)+'_'+str(Ci)+'\n')
            count+=1

# remove duplicates

clist = list(set(clist))
#print clist

# write into file
                         
f=open(path + lname + ostr,'w')
f.writelines(clist)
f.close()

raw_input("Press<enter>")

