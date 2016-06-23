#!/usr/local/bin/python2.7
# import a pdb
# a function: find its center of mass (ca)
# expand the pdb according to 1. lattice dimensions 2. its native latice
# find 1 to 1 correspondence between the center of mass of all the pdbs in 1 and 2
# align the center pose in 1 and 2 
##~wangyr/scripts/pdb_util/superimpose_tmalign.py -n 3T46.pdb  -m 4K9J.pdb -p
#~wangyr/bin/TMalign 1TD4_0001.pdb 1TD4_00000221.pdb
# calculate the overall rms

from os import system,popen
import string
from sys import argv, stdout, exit
import math
from math import sin,cos, sqrt, hypot
import numpy as np
import subprocess
from numpy.core.umath_tests import inner1d
import os.path
import itertools

#calculates rms
def cal_rms( matA, matB ):
    L = matA.shape[0]
    if (L<1): return 0
    dx = matA - matB
    dx2 = inner1d(dx,dx)

    return np.sqrt( sum(dx2)/L )

#gets CA coordinates from pdb
def get_CA_matx( pdb ):
    '''
    get a dict = { residue_num:{ atom:xyz }}
    '''
    xyzDict = {}
    nres = 0
    with open( pdb, "r" ) as f:
        for l in f:
            if l.startswith("ATOM"):
                atom = l[12:16].strip()
                if atom == "CA":
                    res   = int( l[22:26])
                    xyz   = map(float, [ l[30:38], l[38:46], l[46:54] ])
                    xyzDict[ res ] = xyz
                    nres += 1

    matx = np.zeros([ nres, 3 ])
    rsds = sorted( xyzDict.keys() )
    i=0
    #print "rsds", rsds
    for res in rsds:
        #print res
        matx[i] = xyzDict[ res ]
        #print i,res, matx[i], xyzDict[ res ]
        i+=1
    return matx
    
#gets CA coordinates from python object
def get_CA_matx_from_py( pdb ):
    xyzDict = {}
    nres = 0
    for l in pdb:
        if l.startswith("ATOM"):
            atom = l[12:16].strip()
            if atom == "CA":
                res   = int( l[22:26])
                xyz   = map(float, [ l[30:38], l[38:46], l[46:54] ])
                xyzDict[ res ] = xyz
                nres += 1

    matx = np.zeros([ nres, 3 ])
    rsds = sorted( xyzDict.keys() )
    i=0
    #print "rsds", rsds
    for res in rsds:
        #print res
        matx[i] = xyzDict[ res ]
        #print i,res, matx[i], xyzDict[ res ]
        i+=1
    return matx

#kabsch algorithm
def kabsch(P, Q, output=False):
    """ The Kabsch algorithm

    http://en.wikipedia.org/wiki/Kabsch_algorithm

    The algorithm starts with two sets of paired points P and Q.
    P and Q should already be centered on top of each other.

    Each vector set is represented as an NxD matrix, where D is the
    the dimension of the space.

    The algorithm works in three steps:
    - a translation of P and Q
    - the computation of a covariance matrix C
    - computation of the optimal rotation matrix U

    The optimal rotation matrix U is then used to
    rotate P unto Q so the RMSD can be caculated
    from a straight forward fashion.

    """

    # Computation of the covariance matrix
    C =  np.dot( np.transpose(P), Q)

    # Computation of the optimal rotation matrix
    # This can be done using singular value decomposition (SVD)
    # Getting the sign of the det(V)*(W) to decide
    # whether we need to correct our rotation matrix to ensure a
    # right-handed coordinate system.
    # And finally calculating the optimal rotation matrix U
    # see http://en.wikipedia.org/wiki/Kabsch_algorithm
    V, S, W =  np.linalg.svd(C)
    d = ( np.linalg.det(V) *  np.linalg.det(W)) < 0.0

    if d:
        S[-1] = -S[-1]
        V[:,-1] = -V[:,-1]

    # Create Rotation matrix U
    U =  np.dot(V, W)

    # Rotate P
    P =  np.dot(P, U)

    if output:
        return P, cal_rms(P, Q)

    return cal_rms(P, Q)


#calculates COM
def cal_com(ca_matrix):
    com=np.mean(ca_matrix, axis=0)
    #print com
    return com

#expand pdbs
def expand(pdb,radius):
    outpdb = pdb.split(".pdb")[0]+"_symm.pdb"
    if not os.path.isfile(outpdb):
        cmd='~/Rosetta/main/source/bin/pdb_gen_cryst.default.linuxgccrelease '+pdb +' '+ str(radius) +' > ' + outpdb
        #cmd='~/Rosetta/main/source/src/apps/public/symmetry/make_symmdef_file.pl -m cryst -p '+ pdb +' -r ' + str(radius)
        system(cmd)
    return outpdb

#process expanded pdbs, return COM and coordinates for CA
def process_expanded(pdb):
    chain_set=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', 'a', 'b' ,'c','d','e','f', 'g', 'h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    chains={}
    chains_com={}
    for i in chain_set:
        with open( pdb, "r" ) as f:
            for l in f:
                if len(l)<21:
                    continue
                if (i==l[21])&(l.startswith("ATOM")):
                    chains.setdefault(i,[]).append(l)
                    chains_com[i]=0
    for i in chains.keys():
        chains[i]=get_CA_matx_from_py(chains[i])
        chains_com[i]=cal_com(chains[i])
        #print len(chains[i])
        #print i, chains[i],chains_com[i]
    #print chains['C'], len(chains),len(chains['C']), len(chains['C'][1]),chains_com
    return chains, chains_com

#extract chain A from pdbs
def extract_A(pdb):
    pdb_a=pdb.split(".pdb")[0]+'A.pdb'
    if not os.path.isfile(pdb_a):
        cmd='/work/wangyr/scripts/pdb_util/extract_chains_from_pdb.py -p '+pdb+' -c A'
        system(cmd)
    return pdb_a
        
#main function
if __name__=="__main__":
    nativename=argv[1]
    modelname=argv[2]
    
#get CA coordinates of input pdb
    nativeCA=get_CA_matx(nativename)
    modelCA=get_CA_matx(modelname)
    
#get center of mass based on CA
    nativeCACOM=cal_com(nativeCA)
    modelCACOM=cal_com(modelCA)

#expand pdbs based on symmetry operations
    native_expanded=expand(nativename,12)
    model_expanded=expand(modelname,21)
    
#process expanded structures, each variables now contain 2 elements, CA coordinates (0) and COM (1)
    native_expanded_processed=process_expanded(native_expanded)
    model_expanded_processed=process_expanded(model_expanded)
    #print native_expanded_processed[1] 
    #print model_expanded_processed[1]
    
#extract chain A from both expanded structures
    native_expanded_A=extract_A(native_expanded)
    model_expanded_A=extract_A(model_expanded)

    
#do TM align of chain A's of both expanded structures to get the translation+rotation matrix
    trans=  [[0 for x in xrange(1)] for x in xrange(3)] 
    rot=[[0 for x in xrange(3)] for x in xrange(3)] 
    tm_name=modelname+'.tm'
    cmd='~wangyr/bin/TMalign ' + native_expanded_A +' ' + model_expanded_A + ' >'+tm_name
    system(cmd)
    
#find the index of numbers to extract
    f = open ( tm_name , 'r')
    for i, line in enumerate(f,1):
        if 'Rotation matrix to rotate' in line:
            #print i,line
            index=i
            #print index
    f.close()
    fp = open ( tm_name , 'r')
    for i, line in enumerate(fp):
        if i == index+1:
            trans[0]=float(line.split()[1])
            rot[0][0]=float(line.split()[2])
            rot[0][1]=float(line.split()[3])
            rot[0][2]=float(line.split()[4])
        if i==index+2:
            trans[1]=float(line.split()[1])
            rot[1][0]=float(line.split()[2])
            rot[1][1]=float(line.split()[3])
            rot[1][2]=float(line.split()[4])
        if i==index+3:
            trans[2]=float(line.split()[1])
            rot[2][0]=float(line.split()[2])
            rot[2][1]=float(line.split()[3])
            rot[2][2]=float(line.split()[4])
    #map(float,trans)
    #map(float,rot)
    #print trans
    #print rot
#realign the coordinates
    for i in native_expanded_processed[1].keys():
        #print i, native_expanded_processed[0][i]
        native_expanded_processed[0][i][:]=[np.dot(rot,x)+trans for x in native_expanded_processed[0][i]]
        #print native_expanded_processed[0][i], 'a',model_expanded_processed[0][i]
        #print i, native_expanded_processed[1][i],'rot',rot,'trans',trans
        native_expanded_processed[1][i]=np.dot(rot,native_expanded_processed[1][i])+trans
        #print native_expanded_processed[1][i]
        #print native_expanded_processed[1][i], 'model',model_expanded_processed[1][i],"\n"
        
        
#==================TRANSLATION ONLY===============    
# #calculate offset between the starting pdbs of model and native
#     dist=native_expanded_processed[1]['A']-model_expanded_processed[1]['A']
#     #print dist, native_expanded_processed[1]['A'],model_expanded_processed[1]['A']
#     
# #move all the structures of one pdb so that the COM of chain A's overlap
#     for i in native_expanded_processed[1].keys():
#         #print native_expanded_processed[0][i], dist
#         native_expanded_processed[0][i][:]=[x-dist for x in native_expanded_processed[0][i]]
#         #print native_expanded_processed[0][i]
#         #print native_expanded_processed[1][i], dist
#         native_expanded_processed[1][i]=native_expanded_processed[1][i]-dist
#         #print native_expanded_processed[1][i], model_expanded_processed[1][i],"\n"
        
    
#find 1 to 1 correspondence between expanded model and native pdbs by comparing COMs
    #print native_expanded_processed[1]['B'][1]
    #print model_expanded_processed[1]['B'][1]
    new_model_COM={}
    new_model_CA={}
    temp_ca={}
    temp_com={}   
    tolerance=20
    for i in native_expanded_processed[1].keys():
        for j in model_expanded_processed[1].keys():
            if sqrt((native_expanded_processed[1][i][0]-model_expanded_processed[1][j][0])**2 + (native_expanded_processed[1][i][1]-model_expanded_processed[1][j][1])**2+ (native_expanded_processed[1][i][2]-model_expanded_processed[1][j][2])**2)<tolerance:
                temp_ca.setdefault(i,[]).append(model_expanded_processed[0][j])
                temp_com.setdefault(i,[]).append(model_expanded_processed[1][j])
#                 print temp_ca
#                 print temp_com


#find the closest partner
    for i in temp_com.keys():
        new_model_COM[i]=temp_com[i][0]
        new_model_CA[i]=temp_ca[i][0]
        for j in range(len(temp_com[i])):
#             print temp_com[i][j],i,j
            if (sum(abs(native_expanded_processed[1][i]-temp_com[i][j]))<sum(abs(native_expanded_processed[1][i]-new_model_COM[i]))):
                new_model_COM[i]=temp_com[i][j]
                new_model_CA[i]=temp_ca[i][j]
#                 new_model_COM[i]=model_expanded_processed[1][j]
#                 new_model_CA[i]=model_expanded_processed[0][j]
    #print new_model_COM
    #print native_expanded_processed[1]
#     print len(new_model_COM), len(native_expanded_processed[1])
    #print new_model_COM
    #print native_expanded_processed[1]
    
    
#calculate overall rms using the kabsch algorithm
    tempmo=[]
    tempna=[]
    for i in new_model_CA.keys():
        tempmo.append(new_model_CA[i])
        tempna.append(native_expanded_processed[0][i])
        #print temp
    #flatten the list
    naca = [val for subl in tempna for val in subl]
    moca = [val for subl in tempmo for val in subl]
    #convert the list to array
    naca=np.asarray(naca)
    moca=np.asarray(moca)
    #shift the centers to origin
    naca= naca-cal_com(naca)
    moca= moca-cal_com(moca)
    final_rms=kabsch(naca,moca)
    #print final_rms, cal_rms(moca, naca)
    #print naca, cal_com(naca), 'and \n', naca-cal_com(naca)
    
#if not all of the native expansions can find a partner, set rms to 9999
    if (len(native_expanded_processed[1])>len(new_model_COM)):
#         print native_expanded_processed[1] 
#         print new_model_COM
#         print len(native_expanded_processed[1]), '>', len(new_model_COM), ' not all native found partners'
        final_rms=9999
    #print final_rms
        
#save final_rms to an output file
    outname=modelname+'.rms'
    file = open(outname, 'w+')
    file.write(str(final_rms))
    file.close()
    comm=modelname+".cmd"
    os.remove(comm)
    os.remove(model_expanded)
    os.remove(tm_name)
    os.remove(modelname)
    os.remove(native_expanded_A)
    os.remove(model_expanded_A)