William Sexton
12/8/16
Contact Ian Schmutte (schmutte@uga.edu)

Programs to build a population level income dataset from 5-year ACS sample data for 18-64 yr olds using the Bayes bootstrap.

execute with
> python ACS_main.py ss14pusa.csv ss14pusb.csv ss14pusc.csv ss14pusd.csv


INPUTS: 
	Must have the following four data files in your working directory: 
	ss14pusa.csv
	ss14pusb.csv
	ss14pusc.csv 
	ss14pusd.csv

	These files are included with this archive under $A/data/raw/ECONPRIV-ACS-RAW/csv_pus.zip

OUTPUTS: 
	1. ACS.log
		log file that records start and end execution times
	
	2. ACS_Pop.csv
		CSV file with N=XXXXXXXXX rows and one variable -- PINCP, which records the bin within which the reported value of income falls.



PROGRAM DESCRIPTION
	ACS_main.py
		Takes ss14pusa.csv, ss14pusb.csv, ss14pusc.csv, ss14pusd.csv files and runs ACS_data.py.
		To facilitate replication, a random seed is set.
	
	ACS_data.py
		Concatenates input files and strips away everything but ADJINC, PWGTP, AGEP, PINCP.
		AGEP is used to filter out records for individuals under 18 or over 64 then AGEP is removed.
		Bayesian bootstrap is used to construct the population level datafile.
		ADJINC is used to identify the year of each record within the Bayesian bootstrap process then to convert PINCP to 2012 dollars then ADJINC is removed.
		PWGTP is used within the Bayesian bootstrap process and then dropped.
		PINCP is converted to record the bin within which the value of income falls.

		Output file name can be changed if needed.		 
