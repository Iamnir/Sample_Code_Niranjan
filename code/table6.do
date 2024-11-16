*******************************************************************************
// FILE: Replication of Indian-Judicial Bias for Crime against Property offenses 
// Author: Niranjan Kumar 
// Users : Dr. Nirupama Kulkarni, Dr. Abhiman Das 
*******************************************************************************


/******************************/
/* run the last name analysis */
/******************************/
use $jdata/justice_same_names_property_crime, clear


la var same_last_name "Same last name"
la var acq "Acquitted"

/* four regressions for the table. With and without judge FE, loc-month and loc-year fixed effects */
/* unweighted, without and with judge FE */
eststo clear

/*column 1*/ 
reghdfe acq same_last_name def_female def_muslim, absorb(dgroup loc_month acts)
estadd local FE "Court-month"
estadd local judge "No"
estadd local igw "No"
estadd local lsname "Yes"
estimates store m1 


/* store sample size from regression above in a local */
count if e(sample) == 1
local sample_1: di `r(N)'

/* store bias coefficient in a local */
local last_name_cm: di _b["same_last_name"]

/*column 2*/ 
reghdfe acq same_last_name def_female def_muslim, absorb(dgroup loc_month acts judge)
estadd local FE "Court-month"
estadd local judge "Yes"
estadd local igw "No"
estadd local lsname "Yes"
estimates store m2 



/*column 3*/ 
reghdfe acq same_last_name def_female def_muslim [pw=wt], absorb(dgroup loc_month acts judge)
estadd local FE "Court-month"
estadd local judge "No"
estadd local igw "Yes"
estadd local lsname "Yes"
estimates store m3 

/*column 4*/ 
reghdfe acq same_last_name def_female def_muslim [pw=wt], absorb(dgroup loc_year acts judge)
estadd local FE "Court-year"
estadd local judge "Yes"
estadd local igw "Yes"
estadd local lsname "Yes"
estimates store m4 

/* store sample size from regression above in a local */
count if e(sample) == 1
local sample_2: di `r(N)'

/* store bias coefficient in a local */
local last_name_cy: di _b["same_last_name"]

/*column 5*/ 
reghdfe acq same_last_name same_rare def_female def_muslim [pw=wt], absorb(dgroup loc_year acts)
estadd local FE "Court-year"
estadd local judge "No"
estadd local igw "Yes"
estadd local lsname "Yes"
estimates store m5

/*column 6*/ 
reghdfe acq same_last_name same_rare def_female def_muslim [pw=wt], absorb(dgroup loc_year acts judge)
estadd local FE "Court-year"
estadd local judge "Yes"
estadd local igw "Yes"
estadd local lsname "Yes"
estimates store m6

/* store sample size from regression above in a local */
count if e(sample) == 1
local sample_3: di `r(N)'

/* store bias coefficient in a local */
local last_name_cy1: di _b["same_last_name"]

/* store bias coefficient in a local */
local last_name_cy2: di _b["same_rare"]


esttab m1 m2 m3 m4 m5 m6 using $out\JBtable6_last_names_New.tex, replace se(3) label star(* 0.10 ** 0.05 *** 0.01) scalars("FE Fixed Effect" "judge Judge Fixed Effect" "igw Inverse Group Weight" "lsname Last Name Fixed Effect") drop(_cons def_female def_muslim) b(3)  

/* write stored statistics in the paper stats csv file */
store_property_data `sample_1' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-month: sample") group("same caste bias")
store_property_data  `sample_2' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-year: sample") group("same caste bias")
store_property_data  `sample_3' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-year: sample") group("same caste bias")
store_property_data  `last_name_cm' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-month: coef") group("same caste bias")
store_property_data  `last_name_cy' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-year: coef") group("same caste bias")
store_property_data  `last_name_cy1' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-year: coef") group("same caste bias")
store_property_data  `last_name_cy2' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Last name bias result - court-year: coef") group("same caste bias")



