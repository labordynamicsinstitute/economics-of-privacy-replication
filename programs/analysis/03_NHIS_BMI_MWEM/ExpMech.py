#ExpMech.py
#William Sexton
#2/20/2017

import numpy as np


def ExpMech(data,synthData,queries,epsilon,pastQueries):
    """Exponential Mech selects a query from a probability distribution
    based on relative scores of each query when applied
    to real and synthetic data. Use laplace approximation for
    exponential distribution as in HLM
    
    Proconditions: data is histogram of size dim with sum n,
    synthData is histogram with same size and sum as data,
    queries is dimQ x dim matrix whose rows are linear queries,
    epsilon is privacy (noise) parameter,
    pastQueries is a list of indices corresponding to previously selected queries.
    
    Returns: index of selected query"""
        
    score=abs(queries*(synthData-data))
    if pastQueries != []:
        score[pastQueries]=np.zeros(np.size(pastQueries)) #Previously selected queries get a score of zero.
    
    return np.argmax(score +np.random.laplace(0,1/epsilon,len(score)))


