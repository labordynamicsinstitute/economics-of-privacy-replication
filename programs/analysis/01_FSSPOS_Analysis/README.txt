Ian M. Schmutte (schmutte@uga.edu)
3 March 2017

This folder contains code used to analyze data from the Federal Statistical System Public Opinion Survey to compute willingness to pay for the application to ACS income data in Abowd and Schmutte (2017) "Revisiting the Economics of Privacy"

Data from the FSSPOS are not confidential, but are currently embargoed by the US Census Bureau. The Bureau plans to archive these files with Open ICPSR in the near future. When they do, this replication archive will be updated with the relevant data and details.

The documentation, and when available, the data, are included with this archive in $A/data/raw/ECONPRIV-FSSPOS-RAW

The code in this folder stacks the data across each wave of the FSSPOS and harmonizes the data according to the documentation.

To execute the code, it may be necessary to edit sasconfig.sas to update the "interwrk" libname to point to the relevant folder containing the raw data on your system
Program Sequence:
	data_stackall.sas
	mk_fss_analysis_data.sas
	fss_mi_threadN.sas (N=0--4)
	fss_mi_thread_fs14_fs11_N.sas (N=0--4)
	fss_stack_implicates.sas
	fss_poly_corr_fs07_fs11.sas
	fss_poly_corr_fs14_fs11.sas
