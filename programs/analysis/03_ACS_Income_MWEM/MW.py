#MW.py
#William Sexton
#4/20/16

import numpy as np
from scipy import sparse
def MW(synthData,q,m,response,n):
    """Updates synthData according to multiplicative weights process described in HLM.
    
    Precondition: synthData is histogram of size dim with sum n,
    q is a linear query
    m is a noisy response to query output on the true database,
    response is the ouput of the query of the synthetic database,
    
    Returns: New histogram of updated synthetic data.
    """
    p = np.multiply(synthData,(np.exp(q*(m-response)/(2*n))))
    return n*p/np.sum(p)