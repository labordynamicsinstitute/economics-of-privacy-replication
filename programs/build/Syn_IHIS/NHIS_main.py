#NHIS_main.py
#William Sexton
#2/16/2017

#imports
import pandas
import numpy as np
import sys
import csv



def main():
    """Takes nhis dta file as commandline argument and outputs
    Bayesian bootstrap population level bmi data for 2015 in a csv file"""
    #load data
    retain_vars=['year','sampweight','bmi']
    df=pandas.read_stata(sys.argv[1],columns=retain_vars) #Reads file from commandline argument
    df=df[df['year']=='2015'] #filter by year 
    df=df[df['bmi']!=0] #drop out of universe
    df=df[df['bmi']<99.9] #drop missing data, 3% of in universe observations.
    df=df.drop('year',1) 
    
    totalWgt=df.sum(axis=0)[0] #sum of sample weights
    n_nhis=df.shape[0] #number of nhis observations
    N=242977154 #target population level
    df=df.values #convert dataframe to 2d array 
    
    #Bayesian bootstrap
    np.random.seed(3545) #To facilitate replication
    alpha=[(row[0]*float(N)*n_nhis)/(totalWgt**2) for row in df]
    theta=np.random.dirichlet(alpha)
    counts=np.random.multinomial(N,theta)
    
    #generate population level output file
    with open('NHIS_Population.csv','ab') as ofile:
        writer=csv.writer(ofile)
        writer.writerow(['bmi'])
        for index,value in enumerate(counts):
            for i in range(value):
                writer.writerow([df[index][1]])   

if __name__ == '__main__':
    main()