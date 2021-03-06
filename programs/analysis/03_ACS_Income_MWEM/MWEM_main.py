#MWEM_main.py
#William Sexton
#2/20/2017

"""Implemation of Multiplicative Weights Exponential Mechanism algorithm"""

#imports
import logging
import sys
import numpy as np
from scipy import sparse
from scipy import stats
import csv
from data import Data
import MWEM
import query


def round_info(n,dimChi,epsilon,queries,data,mwemState,Q,iterations):
    logging.info('Worst error (relative to n): %s',np.max(abs(queries*(data-mwemState))/n))
    logging.info('MSE (relative to n): %s',np.sum(np.power((queries*(data-mwemState)/n),2)))
    logging.info('mean in synthetic histogram=%s',np.mean(mwemState))
    logging.info('mean in true histogram=%s',np.mean(data))
    logging.info('Std. Dev. in synthetic histogram=%s',np.std(mwemState))
    logging.info('Std. Dev. in true histogram=%s',np.std(data))
    A=data+np.finfo(float).eps
    B=mwemState+np.finfo(float).eps
    logging.info('KL Divergence=%s', stats.entropy(A/np.sum(A),B/np.sum(B)))
    guarantee=2*n*np.sqrt(np.log(dimChi)/iterations)+10*iterations*np.log(Q)/epsilon
    logging.info('error guarantee (relative to n): %s', guarantee/n)
    

def main():
    """Configure log"""
    #Change filename to start new log otherwise info will append to current log
    logging.basicConfig(filename='MWEMacs.log',format='%(asctime)s %(message)s', level=logging.INFO)
    logging.info('Started')
    
    """load data"""
    #Read data from csv file.
    logging.info('Reading file %s',sys.argv[1])
    data=Data(sys.argv[1])     
    n=data.n
    dimChi=data.dimChi
    logging.info('File loaded')
    
    """Generate Queries"""
    logging.info('Generating queries')
    queries=query.build_queries(data.db,dimChi)
    Q=queries.shape[0]
    logging.info('Queries generated')
    
    """algorithm parameters"""
    #iterations=round(((n*np.sqrt(np.log2(dimChi))*epsilon)/(10*np.log2(Q)))**(float(2)/3))   #optimal T from HLM
    iterations=3159
    repitions=3
    data=data.hist
    n=np.sum(data) 
    dim=np.size(data)
    samples=30
    
    """epsilon grid"""
    #grid_size=10
    #eps_grid=np.cumsum((1/float(grid_size))*np.ones(grid_size))
    eps_grid=[.0442] #for custom gird or single value
    grid_size=len(eps_grid)
    
    kl_measurements=np.zeros(grid_size)
    mse_measurements=np.zeros(grid_size)
    max_error_measurements=np.zeros(grid_size)
    
    """Log parameters"""
    logging.info('Sample size=%s',n)
    logging.info('Size of universe=%s',dimChi)
    logging.info('Iterations=%s',iterations)
    logging.info('Samples=%s',samples)

    """run MWEM"""
    #Generate samples for specified epsilon levels
    logging.info('Running MWEM')
    for samp in range(samples):
        for e in range(grid_size):
            epsilon=eps_grid[e]
            logging.info('epsilon=%s',epsilon)
            mwemState=MWEM.MWEM(data,n,dim,queries,iterations,repitions,epsilon)
            A=data+np.finfo(float).eps
            B=mwemState+np.finfo(float).eps
            round_info(n,dimChi,epsilon,queries,data,mwemState,Q,iterations)
            kl_measurements[e]=stats.entropy(A/np.sum(A),B/np.sum(B))
            max_error_measurements[e]=np.max(abs(queries*(data-mwemState))/n)
            mse_measurements[e]=np.sum(np.power((queries*(data-mwemState)/n),2))
        
        
    
        logging.debug('kl_measurements: %s', kl_measurements)
        logging.debug('max_error: %s', max_error_measurements)
        logging.debug('mse: %s', mse_measurements)
    
    #Save output to csv files
    #With each run of program, new sample data will be appended to the output files unless file names are changed
        with open('ACS_kl_measurements.csv','ab') as ofile:
            writer=csv.writer(ofile)
            writer.writerow(kl_measurements)
        with open('ACS_max_error_measurements.csv','ab') as ofile:
            writer=csv.writer(ofile)
            writer.writerow(max_error_measurements)
        with open('ACS_mse_measurements.csv','ab') as ofile:
            writer=csv.writer(ofile)
            writer.writerow(mse_measurements)
    logging.info('Finished')
      
   
if __name__ == '__main__':
    np.random.seed(535)
    main()
    
    
    
