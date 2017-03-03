#query
#William Sexton
#2/20/17
import numpy as np
from scipy import sparse
import numpy.matlib
import itertools

def build_queries(db,dimChi):
    """Creates all range queries over income intervals
    input: db-database
    dimChi-dimension of histogram
    return: query matrix
    """
      
    steps=[dimChi-i for i in range(dimChi)] #Records number of bin intervals of length 1, length 2, etc.
    steps.insert(0,0)
    cumsteps=np.cumsum(steps) #Cumulative sum.
    tot=cumsteps[-1] #Total number of queries.
    queries=sparse.lil_matrix((tot,dimChi))
    for size in xrange(dimChi):
        for i in xrange(dimChi-size):
            queries[i+cumsteps[size],i:i+size+1]=1
    return queries.tocsr()
    
   


