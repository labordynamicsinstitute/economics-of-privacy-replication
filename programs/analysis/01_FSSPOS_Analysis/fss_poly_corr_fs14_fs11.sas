/*Ian M. Schmutte*/
/*2 February 2016*/
/*8 June 2016, John Abowd */

%include "sasconfig.sas";
options fullstimer obs=max fmtsearch = (fmtlib);

/*after fss_stack_implicates.sas*/
ods listing close;
proc corr data=interwrk.fss_imps_fs14_fs11_stacked polychoric;
  var acc_fs07 income;
  by _Imputation_;
  ods output PolychoricCorr=interwrk.fss_corrs_acc_fs14_inc;
run;

proc corr data=interwrk.fss_imps_fs14_fs11_stacked polychoric;
  var pri_fs11 income;
  by _Imputation_;
  ods output PolychoricCorr=interwrk.fss_corrs_pri_fs11_inc;
run;

ods listing;
proc print data=interwrk.fss_corrs_acc_fs14_inc(obs=20);
run;

data interwrk.fss_corrs_acc_fs14_inc;
  set interwrk.fss_corrs_acc_fs14_inc;
  varerr=stderr*stderr;
run;

proc univariate data=interwrk.fss_corrs_acc_fs14_inc;
  var corr varerr;
  title "Polychoric correlation between income and acc_fs14";
run;

data interwrk.fss_corrs_pri_fs11_inc;
  set interwrk.fss_corrs_pri_fs11_inc;
  varerr=stderr*stderr;
run;

proc univariate data=interwrk.fss_corrs_pri_fs11_inc;
  var corr varerr;
  title "Polychoric correlation between income and pri_fs11";
run;
