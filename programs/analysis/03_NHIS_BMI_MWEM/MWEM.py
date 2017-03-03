#MWEM.py
#William Sexton
#11/16/2016

import numpy as np
from scipy import sparse
import ExpMech
import MW
import logging



def MWEM(data,n,dim,queries,iterations,repetitions,epsilon):
    """Preconditions:
    data is a dim X 1 numpy array histogram representation of data,
    n is the number of records in the database, dim is the number of types in the database,
    queries is dimQ x dim numpy array with row sum=1,
    iterations, repetitions are ints
    epsilon is the desired privacy level
    
    Returns: 1D array of final synthetic data average after Multiplicative Weights process"""
   
    synthData=n*(1/float(dim))*np.ones(dim) #Uniform distribution over D
    synthDataAvg = np.zeros(dim)
    epsil = float(epsilon)/(2*iterations) #\ell_1 sensitivity scaling
    mwemState_queryInd=[]
    mwemState_truth = np.zeros(iterations) 
    mwemState_measurement = []
    usedQueries = [] 
    
    for iter in xrange(iterations):
        
        #1. Select query via exponential mechanism
        queryInd = ExpMech.ExpMech(data,synthData,queries,epsil,mwemState_queryInd)
        q=queries[queryInd,:]
        usedQueries.append(q.toarray().reshape(-1))
        mwemState_queryInd.append(queryInd)
        logging.debug('query selected')
        
        #2. Distort query response using Lap Mech
        mwemState_truth[iter] = q*data
        mwemState_measurement.append(mwemState_truth[iter]+np.random.laplace(0,1/epsil)) 
        logging.debug('query response distorted')
        
        #3. Update synthetic data using MW
        for rep in range(repetitions):
            for i in range(iter+1):
                q=usedQueries[i]
                m=mwemState_measurement[i]
                r=np.dot(q,synthData)
                synthData = MW.MW(synthData,q,m,r,n)
                
        synthDataAvg = synthDataAvg + synthData/iterations
        
        logging.debug('one iteration')
    
    logging.debug('Selected Queries: %s',mwemState_queryInd)
    
    return synthDataAvg


