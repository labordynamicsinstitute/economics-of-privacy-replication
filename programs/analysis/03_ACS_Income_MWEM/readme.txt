William Sexton
2/20/17
contact: Ian Schmutte (schmutte@uga.edu)


This code implements the application of MWEM to synthetic ACS income data.

see run.sh/run_dev.sh for commands to run. Runs on python 2.7 anaconda distribution.

INPUT: 
	requires ACS_Pop.csv, included with this archive in $A/data/ECONPRIV-SYN/SYN-ACS/

OUTPUTS:
	Program produces S samples for epsilon value E executing T iterations of the MWEM algorithm. Modify in code.

	Logging information appends to current log file. To start a new log the logging filename must be changed in MWEM_main.py. Logging timestamps start and end time as well as other execution checkpoints and information.

	Program saves three csv output files containing kl_divergence, max_error, and mse for each sample at each epsilon level. csv files are appended to on each new run of the program. Change output filenames in MWEM_main.py to start new output files. 

CSV file requirements
=====================
Files must have header record, and be in Unix format. Transform to Unix format 
by running "dos2unix file.csv".
