#data.py
#William Sexton
#2/20/17
import csv
import numpy as np
from scipy import sparse
import collections
import itertools


class Data:
  def __init__(self,fname):
    with open(fname,'r') as f:
          data_iter = csv.reader(f, 
                        delimiter = ',', 
                        quotechar = '"')
          header=data_iter.next()
          data=[float(data[0]) for data in data_iter]
          hist,bins=np.histogram(data,800)  #Specify number of bins here.  
          self.hist=hist
          self.n=sum(self.hist)
          self.dimChi=len(self.hist)
         
    
