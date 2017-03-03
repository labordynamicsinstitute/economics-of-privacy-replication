#ACS_main.py
#William Sexton
#2/16/2017

import numpy as np
import ACS_data
import logging

def main():
    """Configure log"""
    #Change filename with each run or info will append to same log
    logging.basicConfig(filename='ACS.log',format='%(asctime)s %(message)s', level=logging.INFO)
    logging.info('Started')
    #Process ACS data
    ACSdata=ACS_data.Data()
        
    logging.info('Finished')
if __name__ == '__main__':
    np.random.seed(3451)
    main()



