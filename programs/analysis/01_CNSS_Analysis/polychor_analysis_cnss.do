*******************************
* polychor_analysis_cnss.do
* Author: Ian M. Schmutte (schmutte@uga.edu)
* Today: 2 Novermber 2014
* From code archive for Abowd and Schmutte "Revisiting the Economics of Privacy: Population Statistics and Privacy as Public Goods"
* Requires ./all0813-edited.csv, which is available in the replication archive under ./data/raw/CNSS/all0813-edited.csv
* To run, either copy or link the file in the working directory, or modify the path in line 24 below
*******************************
	
	
    capture log close
    log using "./polychor_analysis_cnss.log", replace

	pause on
	set more off
	clear all
	set linesize 200
	set matsize 5000
	#delimit ;

*******************************;

/*Read data*/
	import delimited "./all0813-edited.csv"; 


/*give variables mnemonic names (and transform to be increasing rather than decreasing where relevant)*/
    gen health_share_qual = -1*jaq4+6;
	gen health_share_priv = -1*jaq5+6;
	gen health_rating     = -1*jaq6+6;
	gen inc_cat = .;
	replace inc_cat = hhinc if hhinc<88;
	replace health_share_qual = . if jaq4 >=6;
	replace health_share_priv = . if jaq5 >=6;
	replace health_rating = . if jaq6 >=6;


	sum inc_cat health_share_qual health_share_priv health_rating;

	polychoric inc_cat health_share_qual;

    polychoric inc_cat health_share_priv;

    polychoric inc_cat health_rating;

    polychoric health_rating health_share_qual;

    polychoric health_rating health_share_priv;
	
	capture log close;