/*
   NOTE: You need to edit the `libname` command to specify the path to the directory
   where the data file is located. For example: "C:\ipums_directory".
   Edit the `filename` command similarly to include the full path (the directory and the data file name).
*/

libname IPUMS "..";
filename ASCIIDAT "../ihis_00001.dat";

proc format cntlout = IPUMS.ihis_00001_f;

value YEAR_f
  1963 = "1963"
  1964 = "1964"
  1965 = "1965"
  1966 = "1966"
  1967 = "1967"
  1968 = "1968"
  1969 = "1969"
  1970 = "1970"
  1971 = "1971"
  1972 = "1972"
  1973 = "1973"
  1974 = "1974"
  1975 = "1975"
  1976 = "1976"
  1977 = "1977"
  1978 = "1978"
  1979 = "1979"
  1980 = "1980"
  1981 = "1981"
  1982 = "1982"
  1983 = "1983"
  1984 = "1984"
  1985 = "1985"
  1986 = "1986"
  1987 = "1987"
  1988 = "1988"
  1989 = "1989"
  1990 = "1990"
  1991 = "1991"
  1992 = "1992"
  1993 = "1993"
  1994 = "1994"
  1995 = "1995"
  1996 = "1996"
  1997 = "1997"
  1998 = "1998"
  1999 = "1999"
  2000 = "2000"
  2001 = "2001"
  2002 = "2002"
  2003 = "2003"
  2004 = "2004"
  2005 = "2005"
  2006 = "2006"
  2007 = "2007"
  2008 = "2008"
  2009 = "2009"
  2010 = "2010"
  2011 = "2011"
  2012 = "2012"
  2013 = "2013"
  2014 = "2014"
  2015 = "2015"
;

value ASTATFLG_f
  0 = "NIU"
  1 = "Sample adult, has record"
  2 = "Sample adult, no record"
  3 = "Not selected as sample adult"
  4 = "No one selected as sample adult"
  5 = "Armed force member"
  6 = "AF member, selected as sample adult"
;

value CSTATFLG_f
  0 = "NIU"
  1 = "Sample child-has record"
  2 = "Sample child-no record"
  3 = "Not selected as sample child"
  4 = "No one selected as sample child"
  5 = "Emancipated minor"
;

value AGE_f
  00 = "0"
  01 = "1"
  02 = "2"
  03 = "3"
  04 = "4"
  05 = "5"
  06 = "6"
  07 = "7"
  08 = "8"
  09 = "9"
  10 = "10"
  11 = "11"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
  30 = "30"
  31 = "31"
  32 = "32"
  33 = "33"
  34 = "34"
  35 = "35"
  36 = "36"
  37 = "37"
  38 = "38"
  39 = "39"
  40 = "40"
  41 = "41"
  42 = "42"
  43 = "43"
  44 = "44"
  45 = "45"
  46 = "46"
  47 = "47"
  48 = "48"
  49 = "49"
  50 = "50"
  51 = "51"
  52 = "52"
  53 = "53"
  54 = "54"
  55 = "55"
  56 = "56"
  57 = "57"
  58 = "58"
  59 = "59"
  60 = "60"
  61 = "61"
  62 = "62"
  63 = "63"
  64 = "64"
  65 = "65"
  66 = "66"
  67 = "67"
  68 = "68"
  69 = "69"
  70 = "70"
  71 = "71"
  72 = "72"
  73 = "73"
  74 = "74"
  75 = "75"
  76 = "76"
  77 = "77"
  78 = "78"
  79 = "79"
  80 = "80"
  81 = "81"
  82 = "82"
  83 = "83"
  84 = "84"
  85 = "85 (1963-1968 and 1997 forward: 85+)"
  86 = "86"
  87 = "87"
  88 = "88"
  89 = "89"
  90 = "90 (1996: 90+)"
  91 = "91"
  92 = "92"
  93 = "93"
  94 = "94"
  95 = "95"
  96 = "96"
  97 = "97"
  98 = "98"
  99 = "99+"
;

value SEX_f
  1 = "Male"
  2 = "Female"
;

value EARNINGS_f
  00 = "NIU"
  01 = "$01 to $4999"
  02 = "$5000 to $9999"
  03 = "$10000 to $14999"
  04 = "$15000 to $19999"
  05 = "$20000 to $24999"
  06 = "$25000 to $34999"
  07 = "$35000 to $44999"
  08 = "$45000 to $54999"
  09 = "$55000 to $64999"
  10 = "$65000 to $74999"
  11 = "$75000 and over"
  97 = "Unknown-refused"
  98 = "Unknown-not ascertained"
  99 = "Unknown-don't know"
;

value HEALTH_f
  1 = "Excellent"
  2 = "Very Good"
  3 = "Good"
  4 = "Fair"
  5 = "Poor"
  7 = "Unknown-refused"
  8 = "Unknown-not ascertained"
  9 = "Unknown-don't know"
;

value HEIGHT_f
  00 = "NIU"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
  30 = "30"
  31 = "31"
  32 = "32"
  33 = "33"
  34 = "34"
  35 = "35"
  36 = "36"
  37 = "37"
  38 = "38"
  39 = "39"
  40 = "40"
  41 = "41"
  42 = "42"
  43 = "43"
  44 = "44"
  45 = "45"
  46 = "46"
  47 = "47"
  48 = "48"
  49 = "49"
  50 = "50"
  51 = "51"
  52 = "52"
  53 = "53"
  54 = "54"
  55 = "55"
  56 = "56"
  57 = "57"
  58 = "58 (1996: 58 inches or less)"
  59 = "59"
  60 = "60"
  61 = "61"
  62 = "62"
  63 = "63"
  64 = "64"
  65 = "65"
  66 = "66"
  67 = "67"
  68 = "68"
  69 = "69"
  70 = "70"
  71 = "71"
  72 = "72"
  73 = "73"
  74 = "74"
  75 = "75"
  76 = "76"
  77 = "77 (1996: 77+ inches)"
  78 = "78"
  79 = "79"
  80 = "80"
  81 = "81"
  82 = "82"
  83 = "83"
  84 = "84 (1976 - 1981: 84+ inches)"
  85 = "85"
  86 = "86"
  87 = "87"
  88 = "88"
  89 = "89"
  90 = "90"
  91 = "91"
  92 = "92"
  93 = "93"
  94 = "94+"
  95 = "Unknown-all causes"
  96 = "Exceptionally short or tall"
  97 = "Unknown-refused"
  98 = "Unknown-not ascertained"
  99 = "Unknown-don't know"
;

run;

data IPUMS.ihis_00001;
infile ASCIIDAT pad missover lrecl=129;

input
  YEAR         1-4
  SERIAL       5-10
  STRATA       11-14
  PSU          15-17
  NHISHID    $ 18-31
  HHWEIGHT     32-37
  NHISPID    $ 38-53
  HHX        $ 54-59
  FMX        $ 60-61
  PX         $ 62-63
  PERWEIGHT    64-72
  SAMPWEIGHT   73-81
  FWEIGHT      82-87
  ASTATFLG     88-88
  CSTATFLG     89-89
  PERNUM       90-91
  AGE          92-93
  SEX          94-94
  EARNINGS     95-96
  HEALTH       97-97
  HEIGHT       98-99
  WEIGHT       100-102
  BMICALC      103-106 .1
  BMI          107-110 .2
  NHISIID    $ 111-129
;

label
  YEAR       = "Survey year"
  SERIAL     = "Sequential Serial Number, Household Record"
  STRATA     = "Stratum for variance estimation"
  PSU        = "Primary sampling unit (PSU) for variance estimation"
  NHISHID    = "NHIS Unique identifier, household"
  HHWEIGHT   = "Household weight, final annual"
  NHISPID    = "NHIS Unique Identifier, person"
  HHX        = "Household number (from NHIS)"
  FMX        = "Family number (from NHIS)"
  PX         = "Person number of respondent (from NHIS)."
  PERWEIGHT  = "Final basic annual weight"
  SAMPWEIGHT = "Sample Person Weight"
  FWEIGHT    = "Final annual family weight"
  ASTATFLG   = "Sample adult flag"
  CSTATFLG   = "Sample child flag"
  PERNUM     = "Person number within family (from reformatting)"
  AGE        = "Age"
  SEX        = "Sex"
  EARNINGS   = "Person's total earnings, previous calendar year"
  HEALTH     = "Health status"
  HEIGHT     = "Height in inches without shoes"
  WEIGHT     = "Weight in pounds without clothes or shoes"
  BMICALC    = "Body Mass Index, calculated from publicly released height and weight variables"
  BMI        = "Body mass index"
  NHISIID    = "NHIS unique identifier, injury"
;
/*
format
  YEAR        YEAR_f.
  ASTATFLG    ASTATFLG_f.
  CSTATFLG    CSTATFLG_f.
  AGE         AGE_f.
  SEX         SEX_f.
  EARNINGS    EARNINGS_f.
  HEALTH      HEALTH_f.
  HEIGHT      HEIGHT_f.
;
*/
format
  PERWEIGHT   9.
  SAMPWEIGHT  9.
;

run;

