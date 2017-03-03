William Sexton
2/17/17
contact: Ian Schmutte (schmutte@uga.edu)

This code implements the application of MWEM to synthetic IHIS BMI data.

see run.sh/run_dev.sh for commands to run. Runs on python 2.7 anaconda distribution.

INPUT: 
	requires NHIS_Population.csv, included with this archive in $A/data/ECONPRIV-SYN/SYN-IHIS/

OUTPUTS:
	Program produces 30 samples for specified epsilon values executing T iterations of the MWEM algorithm. Modify in code.

	Logging information appends to current log file. To start a new log the logging filename must be changed in MWEM_main.py. Logging timestamps start and end time as well as other execution checkpoints and information.

	Program saves three csv output files containing kl_divergence, max_error, and mse for each sample at each epsilon level. csv file is overwritten on each new run of the program. Change output filenames in MWEM_main.py. 

CSV file requirements
=====================
Files must have header record, and be in Unix format. Transform to Unix format 
by running "dos2unix file.csv".

