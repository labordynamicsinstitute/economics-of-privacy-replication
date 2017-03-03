/*Ian M. Schmutte*/
/*15 January 2016*/

%let root = ../../../data/raw/ECONPRIV-FSSPOS-RAW;

/*If you copy the entire directory to another system, you should be able to run everything if you only change the line above*/
/*CAVEAT: you may first need to rebuild to format library for your filesystem by executing runall_format.sas within the ./formats subdirectory*/

libname fmtlib "&root./formats";  /*store all formats here*/
libname interwrk "&root.";"



