Code in this folder generates the polychoric correlations for the CNSS data reported in Abowd and Schmutte "Revisiting the Economics of Privacy: Population Statistics and Privacy as Public Goods"

The main program is polychor_analysis_cnss.do
* Author: Ian M. Schmutte (schmutte@uga.edu)
* Today: 2 Novermber 2014

* Inputs: ./all0813-edited.csv, which is available in the replication archive under $A/data/raw/CNSS/all0813-edited.csv
	To run, either copy or link the file in the working directory, or modify the path in line 24
	execute from command line with
	stata -b polychor_analysis_cnss.do

*Outputs: polychor_analysis.log