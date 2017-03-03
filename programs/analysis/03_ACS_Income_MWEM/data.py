#data.py
#William Sexton
#2/16/17
import csv
import numpy as np
from scipy import sparse
import collections
import itertools


class Data:
  """Process ACS data for MWEM algorithm. Builds historgram from input file."""
  def __init__(self,fname):
    with open(fname,'r') as f:
        data_iter = csv.reader(f, 
                        delimiter = ',', 
                        quotechar = '"')
        data_iter.next() #Skips file header.
        d = collections.defaultdict(int)
                
        for a in range(797): #Number of income bins in ACS population-level datafile.
            d[a]=0 #Initialize bin counts.
          
        for data in data_iter:
            d[map(int,data)[0]] +=1 #increment count of income bin associated with data record.
                    
        self.db=d #database
        self.hist=np.asarray(d.values(),dtype='int64') #histogram of binned income.
        self.n=np.sum(self.hist) #number of records
        self.dimChi=len(self.hist) #size of universe
        
   
