William Sexton
11/16/2016
Contact Ian Schmutte (schmutte@uga.edu)

uses Bayes bootstrap to construct a population level database with BMI data discretized into 800 bins from the 2015 IHIS sample contained in ihis_00001.dat.

INPUTS:
	ihis_00001.dat

	This archive includes a copy of the original input file in $A/data/raw/ECONPRIV-IHIS-RAW/

OUTPUTS:
	NHIS_Population.csv which has N=XXX rows and a single variable, BMI, which is a measure of individual BMI aggregated into 800 equally-spaced bins.


	This archive includes a copy of the output file in $A/data/ECONPRIV-SYN/SYN-IHIS



INSTRUCTIONS
	(1) execute $> stata -b read_ihis_00001.do 
	     to produce IHIS_masterfile.dta 
	(2) execute $> python NHIS_main.py IHIS_masterfile.dta
	     to produce NHIS_Population.csv



PROGRAM DESCRIPTION
	read_ihis_00001.do
		Reads ihis_00001.dat into Stata formatted file IHIS_masterfile.dta

	NHIS_main.py 
		Takes IHIS_masterfile.dta file and strips away everything but year, sampweight, and bmi. 
		Year is used to filter out all but 2015 observations then year is removed.
		Out of universe and missing data observations are also dropped. Missing data is about 3% of the in universe observations. 
		Sampweight rescaling is incorporated within the Bayesian bootstrap process. 
		Bayesian bootstrap process is used to construct the population level datafile. 
		To facilitate replication, a random seed is set.

		Output file name can be changed if needed.