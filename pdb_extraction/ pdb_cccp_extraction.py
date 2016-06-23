# pre: a list of pdb file names with parameters
# post: extract out parameters of protein design and reassign into new combo
# by Baihan Lin, June 2016

# read in the list and parse the parameters

path = '/Users/DoerLBH/Dropbox/git/BakerLab_cmd_scripts/pdb_extraction/'
lname = raw_input("Enter pdb backbone name: ")
lstr = ".list"

f=open(path + lname + lstr,'r')
flist=f.readlines()
flist=list(set(flist))
f.close()

first = flist[0]
Amax = Amin = first.split('_')[0]
Bmax = Bmin = first.split('_')[1]
Cmax = Cmin = first.split('_')[2]

# sample finely around the parameters

for bb in flist:
    A = bb.split('_')[0]
    B = bb.split('_')[1]
    C = bb.split('_')[2]
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

# make combinations

for Ai in Aran:
    for Bi in Bran:
        for Ci in Cran:
            print


# remove duplicates


