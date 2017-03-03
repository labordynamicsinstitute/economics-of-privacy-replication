/*Ian M. Schmutte*/
/*15 January 2016*/


%include "sasconfig.sas";
options fullstimer obs=max;

/*Below are all details of the structure of the raw input files*/
%let rotlist = 01_00 01_01 01_02 01_03 01_04 01_05 01_06 01_07 01_08 01_09 01_10 01_11 01_12 02_01 02_02 02_03 02_04 03_00 03_01 03_02;

libname rot01_00 "&root./data/CSM_FSS_raw/Rotation0";
libname rot01_01 "&root./data/CSM_FSS_raw/Rotation1";
libname rot01_02 "&root./data/CSM_FSS_raw/Rotation2";
libname rot01_03 "&root./data/CSM_FSS_raw/Rotation3";
libname rot01_04 "&root./data/CSM_FSS_raw/Rotation4";
libname rot01_05 "&root./data/CSM_FSS_raw/Rotation5";
libname rot01_06 "&root./data/CSM_FSS_raw/Rotation6";
libname rot01_07 "&root./data/CSM_FSS_raw/Rotation7";
libname rot01_08 "&root./data/CSM_FSS_raw/Rotation8";
libname rot01_09 "&root./data/CSM_FSS_raw/Rotation9";
libname rot01_10 "&root./data/CSM_FSS_raw/Rotation10";
libname rot01_11 "&root./data/CSM_FSS_raw/Rotation11";
libname rot01_12 "&root./data/CSM_FSS_raw/Rotation12";

libname rot02_01 "&root./data/CSM_FSS_raw/Second_Contract/Rotation1";
libname rot02_02 "&root./data/CSM_FSS_raw/Second_Contract/Rotation2";
libname rot02_03 "&root./data/CSM_FSS_raw/Second_Contract/Rotation3";
libname rot02_04 "&root./data/CSM_FSS_raw/Second_Contract/Rotation4";

libname rot03_00 "&root./data/CSM_FSS_raw/Third_Contract/Rotation0";
libname rot03_01 "&root./data/CSM_FSS_raw/Third_Contract/Rotation1";
libname rot03_02 "&root./data/CSM_FSS_raw/Third_Contract/Rotation2";


/*Dates correspond to files within each Rotation*/
%let rot01_00_dates = 021912 022612 030412 031112 031812 032512 040112 040812 041512 042212 042912 050612 051312 052012 052712 060312 061012;
%let rot01_01_dates = 061712 062412 070112 070812 071512;
%let rot01_02_dates = 072212 072912 080512 081212;
%let rot01_03_dates = 081912 082612 090212 090912 091612 092312;
%let rot01_04_dates = 093012 100712 101412 102112 102812 110412 111112 111812 112512 120212 120912 121612 122312 123012 010613 011313 012013 012713 020313;
%let rot01_05_dates = 021013 021713 022413 030313 031013;
%let rot01_06_dates = 031713 032413 033113 040713;
%let rot01_07_dates = 041413 042113 042813 050513 051213;
%let rot01_08_dates = 051213 051913 052613 060213;
%let rot01_09_dates = 060913 061613 062313 063013;
%let rot01_10_dates = 070713 071413 072113 072813 080413;
%let rot01_11_dates = 081113 081813 082513 090113;
%let rot01_12_dates = 090813 091513;

%let rot02_01_dates = 100613 101313 102013 102713;
%let rot02_02_dates = 110313 111013 111713 112413 120113;
%let rot02_03_dates = 120813 121513 122213 122913 010514 011214 011914 012614 020214 020914;
%let rot02_04_dates = 021614 022314 030214 030914 031614;

%let rot03_00_dates = pe092814 pe100514 pe101214 pe101914 pe102614 pe110214 w010415 w011115 w092814 w100514 w101214 w101914 w102614 w110214 w110914 w111614 w112314 w113014 w120714 w121414 w122114 w122814;
%let rot03_01_dates = w011815 w012515 w020115 w020815 w021515 w022215 w030115 w030815 w031515 w032215 w032915 w040515 w041215 w041915;
%let rot03_02_dates = w042615 w050315 w051015 w051715 w052415 w053115 w060715 w061415 w062115 w062815 w070515 w071215 w071915 w072615 w080215 w080915;


/*classic macro to count number of items in a macro variable list and assign that number to a new macro variable.*/
%macro listcount(list,letter);
	%global &letter.;
	%let c=1;
		%do %until (%bquote(%scan(&list,&c))=);
    		%let c=%eval(&c+1);
	%end;
	%let &letter.=%eval(&c-1);
%mend;


%listcount(&rotlist.,numrots);

%macro stackall;
	options fmtsearch = (fmtlib);
	    %do j=1 %to &numrots.;
              %let rotnum=%scan(&rotlist.,&j.);
	      %listcount(&&rot&rotnum._dates.,numdates&rotnum.);
            %end;
	data interwrk.raw_stack;
	  set 
	    %do j=1 %to &numrots.;
              %let rotnum=%scan(&rotlist.,&j.);
	        %do i=1 %to &&numdates&rotnum.;
	          %let dt=%scan(&&rot&rotnum._dates.,&i);
	          rot&rotnum..cencoll_&dt. (in=rot&rotnum._&dt.)
                %end;
            %end;
            ;
	    %do j=1 %to &numrots.;
              %let rotnum=%scan(&rotlist.,&j.);
	        %do i=1 %to &&numdates&rotnum.;
	          %let dt=%scan(&&rot&rotnum._dates.,&i);
	          if rot&rotnum._&dt then do;
		    rotnum = "&rotnum.";
		    report_date = "&dt.";
		  end;
                %end;
            %end;
         run;
%mend;

%stackall;

options fmtsearch = (fmtlib);
proc contents data=interwrk.raw_stack;
run;

proc print data=interwrk.raw_stack(obs=0);
run;



