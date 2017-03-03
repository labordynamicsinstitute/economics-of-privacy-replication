/*Ian M. Schmutte*/
/*20 January 2016*/
/*Make extract of variables from FSS stack prior to multiple imputation*/

%include "sasconfig.sas";
options fullstimer obs=max fmtsearch = (fmtlib);


proc format library=fmtlib;
    value racef
             1   = "White"
             2   = "Black or African American"
             3   = "Asian"
             4   = "American Indian or Alaska Native"
             5   = "Native Hawaiian or Pacific Islander"
             6   = "Multiple Races";
    value agef
             1   = "18-24"
             2   = "25-29"
             3   = "30-39"
             4   = "40-49"
             5   = "50-59"
             6   = "60-69"
             7   = "70-79"
             8   = "80-89"
             9   = "90-99";
run;

data interwrk.fss_analysis_data(keep=gender age_bin race ethnicity educ income acc_fs07 acc_fs14 pri_fs11
                                     f_gender f_age f_race f_ethnicity f_educ f_income f_acc_fs07 f_acc_fs14 f_pri_fs11
                                     misspattern);
  set interwrk.raw_stack;
  format income d45f. acc_fs07 acc_fs14 pri_fs11 agr. age_bin sc6f. gender sc7f. age agef. educ d4f. ethnicity d5f. race racef.;
  income = d45;
  if d46 not in (98,99,.) then income = d46;
  acc_fs07 = fs7;
  acc_fs14 = fs14;
  pri_fs11 = fs11;
  age = sc6;
  gender = sc7;
  educ = d4;
  if educ = . then educ = d4_1;
  ethnicity = d5;
  /*race recode*/
  if d69_2 not in (0,8,9) then race = 6; /*multiple races*/
  else race = d69_1; /*defaults to first mention*/
  if race in (8,9,0,.) then do;
    white = d50a=1;
    black = d50b=1;
    asian = d50c=1;
    amind = d50c_1=1;
    pacil = d50e=1;
    if sum(white,black,asian,amind,pacil)>1 then race=6;
    else do;
      if white then race = 1;
      if black then race = 2;
      if asian then race = 3;
      if amind then race = 4;
      if pacil then race = 5;
    end;
  end;
  

  f_age = "0"; f_gender="0"; f_income="0"; f_acc_fs07="0"; f_acc_fs14="0"; f_pri_fs11="0"; f_educ="0";f_ethnicity="0";f_race="0";
  if age < 18 or age > 99 then do;
    age = .;
    f_age = "1";
  end;
  if gender not in (1,2) then do;
    gender =.;
    f_gender="1";
  end;
  if income in (98,99,.) then do;
    income = .;
    f_income = "1";
  end;
  if acc_fs07 in (8,9,.) then do;
    acc_fs07 = .;
    f_acc_fs07 ="1";
  end;
  if acc_fs14 in (8,9,.) then do;
    acc_fs14 = .;
    f_acc_fs14 ="1";
  end;
  if pri_fs11 in (8,9,.) then do;
    pri_fs11 = .;
    f_pri_fs11 = "1";
  end;
  if educ in (0,9,7,8,.) then do;
    educ = .;
    f_educ ="1";
  end;
  if ethnicity in (3,4,.) then do;
    ethnicity = .;
    f_ethnicity ="1";
  end;
  if race in (8,9,0,.) then do;
    race = .;
    f_race = "1";
  end;
  
  misspattern = f_gender||f_age||f_race||f_ethnicity||f_educ||f_income||f_acc_fs07||f_acc_fs14||f_pri_fs11;

  /*collapse age into bins*/
  age_bin = .;
  if age ne . then do;
    if age >=18 and age <= 24 then age_bin=1;
    if age >=25 and age <= 29 then age_bin=2;
    if age >=30 and age <= 39 then age_bin=3;
    if age >=40 and age <= 49 then age_bin=4;
    if age >=50 and age <= 59 then age_bin=5;
    if age >=60 and age <= 69 then age_bin=6;
    if age >=70 and age <= 79 then age_bin=7;
    if age >=80 and age <= 89 then age_bin=8;
    if age >=90 and age <= 99 then age_bin=9;
  end;
run;

proc freq data=interwrk.fss_analysis_data;
  tables gender age_bin race ethnicity educ income acc_fs07 acc_fs14 pri_fs11;
run;

proc freq data=interwrk.fss_analysis_data;
  tables misspattern;
  title "missing data pattern: f_gender||f_age||f_race||f_ethnicity||f_educ||f_income||f_acc_fs07||f_acc_fs14||f_pri_fs11";
run;