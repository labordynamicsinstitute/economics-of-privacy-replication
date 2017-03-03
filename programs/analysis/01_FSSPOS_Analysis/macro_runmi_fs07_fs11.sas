/*Ian M. Schmutte*/
/*20 January 2016*/
/*Macro to run proc MI ten times with ten implicates*/

%macro runmi(thread);
  %do grp = 0 %to 9;
    proc mi data=interwrk.fss_analysis_data nimpute=10 out=interwrk.fss_imps_thread&thread._group&grp.;
      class gender race ethnicity age_bin educ income acc_fs07 pri_fs11;
      fcs nbiter=50
        logistic(ethnicity = age_bin educ income|acc_fs07|pri_fs11 gender race /details) ;
      fcs nbiter=50
        logistic(age_bin = educ income|acc_fs07|pri_fs11 gender race ethnicity /details);
      fcs nbiter=50
        logistic(educ = income acc_fs07 pri_fs11 gender race ethnicity age_bin /details);
      fcs nbiter=50
        logistic(income = acc_fs07|pri_fs11|educ gender ethnicity race age_bin /details);
      fcs nbiter=50
        logistic(acc_fs07 = pri_fs11|income gender  ethnicity race age_bin educ  /details);
      fcs nbiter=50
        logistic(pri_fs11 = gender  ethnicity race age_bin educ income|acc_fs07 /details);
      var gender race ethnicity age_bin educ income acc_fs07 pri_fs11;
      title "Thread &thread. Group &grp.";
    run;
  %end;
%mend;



