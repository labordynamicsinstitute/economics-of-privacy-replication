/*Ian M. Schmutte*/
/*2 February 2016*/

%include "sasconfig.sas";
options fullstimer obs=max fmtsearch = (fmtlib);

/*after fss_stack_implicates.sas*/
ods listing close;
proc corr data=interwrk.fss_imps_stacked polychoric;
  var acc_fs07 income;
  by _Imputation_;
  ods output PolychoricCorr=interwrk.fss_polycorrs_acc_inc;
run;

proc corr data=interwrk.fss_imps_stacked polychoric;
  var pri_fs11 income;
  by _Imputation_;
  ods output PolychoricCorr=interwrk.fss_polycorrs_pri_inc;
run;

ods listing;
proc print data=interwrk.fss_polycorrs_acc_inc(obs=20);
run;

data interwrk.fss_polycorrs_acc_inc;
  set interwrk.fss_polycorrs_acc_inc;
  varerr=stderr*stderr;
run;

proc univariate data=interwrk.fss_polycorrs_acc_inc;
  var corr varerr;
  title "Polychoric correlation between income and acc_fs07";
run;

data interwrk.fss_polycorrs_pri_inc;
  set interwrk.fss_polycorrs_pri_inc;
  varerr=stderr*stderr;
run;

proc univariate data=interwrk.fss_polycorrs_pri_inc;
  var corr varerr;
  title "Polychoric correlation between income and pri_fs11";
run;


