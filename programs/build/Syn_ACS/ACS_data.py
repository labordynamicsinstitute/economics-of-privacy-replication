#data.py
#William Sexton
#2/16/17
import csv
import numpy as np
from scipy import sparse
import collections
import sys
import operator


class Record:
  """Record class contains necessary record information for bootstrap process."""
  def __init__(self,inc,adj,year,weight):
    self.year=year
    self.weight=weight
    self.income=inc
    self.adj2012=adj
    


class Data:
  def __init__(self):
    N=197040596 #Set target population-level.
    
    """Bookkepping"""
    yearCode={1094136:2010,1071861:2011,1041654:2012,1024037:2013,1008425:2014} #To determine year of a record. See ACS 2010-2014 data dictionary for ADJINC.
    yearCount={2010:0,2011:0,2012:0,2013:0,2014:0} #For counting number of records from each year.
    ADJ2012={1094136:1.007624*1.08585701/1.03112956,1071861:1.018237*1.05266344/1.03112956,1041654:1.010207,1024037:1.007549*1.01636470/1.03112956,1008425:1.008425/1.03112956} #Adjustment factors to convert to 2012 dollars. See data dictionary for ADJINC.
    database=[]
    totalWgt=0
    
    """ACS data processing"""
    with open('ACS_Pop.csv','ab') as ofile: #Change output file name here.
      writer=csv.writer(ofile)
      writer.writerow(['PINCP'])
      for t in range(4):
        with open(sys.argv[t+1],'r') as f: #Read four csv input files from commandline arguments
          data_iter = csv.reader(f, 
                        delimiter = ',', 
                        quotechar = '"')
          header=data_iter.next() #list of column variables in ACS datafiles
          retain_vars=['ADJINC','PWGTP','AGEP','PINCP'] #Income adjustment factor, person weight, age, total income
          retain_idx=[i for i,x in enumerate(header) if x in retain_vars] 
          retain_vars=[header[i] for i in retain_idx]
          for row in data_iter:
            row=np.asarray(row)[retain_idx] #Strips away unnecessary variables
            if(int(row[2])<=64 and int(row[2])>=18): #Excludes out of universe records
              yearCount[yearCode[int(row[0])]] +=1 #Increment record count for associated year
              totalWgt += int(row[1]) #Increment total person weight
              database.append(Record(float(row[3]),ADJ2012[int(row[0])],yearCode[int(row[0])],int(row[1]))) #Adds record to database
              
      """Bayesian bootstrap process"""
      alpha=[(float(record.weight)/totalWgt)*yearCount[record.year] for record in database]
      theta=np.random.dirichlet(alpha)
      counts=np.random.multinomial(N,theta)
      
      """Write binned income to output file."""
      for index, value in enumerate(counts):
        for i in range(value):
          writer.writerow([bin_PINCP(const_PINCP(database[index].adj2012,database[index].income))]) #Adjust to 2012 dollars and bin income.
          
   
 
def bin_PINCP(inc):
  """Input income, Return bin number"""
  inc=float(inc)
  if(inc<-16000):
    return 0
  for i in range(795): #795 for 2000, 15,920 for 100, bound of 1576000
    if 2000*(i-8)<=inc<2000*(i-7):
      return i+1
  return 796

def const_PINCP(adj,inc):
  """Input adjustment factor and income, Return adjusted income"""
  return inc*adj
  

  
    
  
