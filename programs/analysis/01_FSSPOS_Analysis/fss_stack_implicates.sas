/*Ian M. Schmutte*/
/*20 January 2016*/
/* 8 June 2016 John M. Abowd */

%include "sasconfig.sas";
%include "macro_runmi.sas";
options fullstimer obs=max fmtsearch = (fmtlib);

/*after fss_mi_thread0-4*/

%macro stack;
  %do thread = 0 %to 4;
    %do group = 0 %to 9;
      data interwrk.fss_imps_fs14_fs11_&thread._group&group.;
        set interwrk.fss_imps_fs14_fs11_&thread._group&group.;
        Imp_num = %eval(&thread.*100)+%eval(&group*10)+_Imputation_;
      run;
/*
      proc freq data=interwrk.fss_imps_fs14_fs11_thread&thread._group&group.;
        tables Imp_num;
      run;
*/
    %end;
  %end;

  data interwrk.fss_imps_fs14_fs11_stacked(drop=Imp_num);
    set
      %do thread = 0 %to 4;
        %do group = 0 %to 9;
          interwrk.fss_imps_fs14_fs11_&thread._group&group.
        %end;
      %end;
      ;
      _Imputation_ = Imp_num;
  run;
%mend;


%stack;
proc freq data=interwrk.fss_imps_fs14_fs11_stacked;
  tables _Imputation_;
run;

