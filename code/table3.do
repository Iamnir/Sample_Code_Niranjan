*******************************************************************************
// FILE: Replication of Indian-Judicial Bias for Crime against Property offenses 
// Author: Niranjan Kumar 
// Users : Dr. Nirupama Kulkarni, Dr. Abhiman Das 
*******************************************************************************


clear all 
set more off 

//set global paths below 

//$out is the target folder for all outputs, such as tables and graphs.
global out   "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication\results"

//$jdata is the folder where you datasets are
global jdata "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication"

//$tmp is the folder for the data files and temporary data files that will be created during the rebuild.
global tmp  "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication\temp"

//$jcode is the code folder of the clone of the replication repo
global jcode "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication\code"

if mi("$out") | mi("$tmp") | mi("$datapath, eg.$mining") {
  display as error "Globals 'out', 'tmp', and 'datapath, eg.$mining' must be set for this to run."
  error 1
}



/**********************************************/
/* Store some basic statistics for validation */
/**********************************************/



/* add ado folder to adopath */
adopath + "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication\ado"

cap log close

log using $out/logfilename.log, text replace



/************/
/* ANALYSIS */
/************/

********************************************************************************
//TABLE-3 
********************************************************************************

/* import analysis dataset */
use $jdata/justice_analysis_property_crime, clear


/* run main regression to tag sample */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)
gen sample = e(sample) == 1


/* store sample count in stats csv */
count if sample == 1
local sample: di %5.3f `r(N)'

/* store summary statistic in stats csv: avg acquittal rate */
sum acq if sample == 1
local acq_mean: di %5.3f `r(mean)'

/* store summary statistic in stats csv: avg conviction rate */
/* note that we have non-conviction as outcome variable */
/* conviction is the exact opposite (1-non-conviction) */
gen conv = 1 - non_conv
sum conv if sample == 1
local conv_mean: di %5.3f `r(mean)'
drop conv

/*
/* tag number of obs for which we have classified gender */
count if !mi(def_female)
local g_sample: di %5.3f `r(N)'

/*tag number of obs for which we have classified religion */
count if !mi(def_muslim)
local r_sample: di %5.3f `r(N)'

/* store defendant gender and religious shares in locals */
count if def_muslim == 1
local share_def_mus: di %5.3f `r(N)'/`r_sample'
count if def_muslim == 0
local share_def_nm: di %5.3f `r(N)'/`r_sample'
count if def_female == 1
local share_def_fem: di %5.3f `r(N)'/`g_sample'
count if def_female == 0
local share_def_mal: di %5.3f `r(N)'/`g_sample'

*/

/**********************/
/* Outcome: Acquitted */
/**********************/

/* column 1 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)

estadd local Fixed_Effect "Court-month"
estadd local Demographic_Controls "No"
estadd local Judge_fixed_effect "No"
eststo ols1 

lincom 

/* column 2 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts) cluster(judge)

estadd local Fixed_Effect "Court-month"
estadd local Demographic_Controls "Yes"
estadd local Judge_fixed_effect "No"
eststo ols2

/* column 3 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts judge) cluster(judge)

estadd local Fixed_Effect "Court-month"
estadd local Demographic_Controls "Yes"
estadd local Judge_fixed_effect "Yes"
eststo ols3 

/* store analysis sample count in local */
count if e(sample) == 1
local gb_cm_n = `r(N)'

/* store gender bias effect from column 3 in local */
local gb_cm: di _b["judge_def_male"]


/* column 4 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_year acts) cluster(judge)
estadd local Fixed_Effect "Court-year"
estadd local Demographic_Controls "No"
estadd local Judge_fixed_effect "No"
eststo ols4

/* column 5 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts) cluster(judge)
estadd local Fixed_Effect "Court-year"
estadd local Demographic_Controls "Yes"
estadd local Judge_fixed_effect "No"
eststo ols5


/* column 6 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts judge) cluster(judge)
estadd local Fixed_Effect "Court-year"
estadd local Demographic_Controls "Yes"
estadd local Judge_fixed_effect "Yes"
eststo ols6

/* store analysis sample count in local */
count if e(sample) == 1
local gb_cy_n = `r(N)'

/* store bias effect from column 6 in local */
local gb_cy: di _b["judge_def_male"]



/* Calculate sum of coefficients for judge_male + judge_def_male */
local sum_ols1 = _b[judge_male] + _b[judge_def_male]
local sum_ols2 = _b[judge_male] + _b[judge_def_male]
local sum_ols3 = _b[judge_male] + _b[judge_def_male]
local sum_ols4 = _b[judge_male] + _b[judge_def_male]
local sum_ols5 = _b[judge_male] + _b[judge_def_male]
local sum_ols6 = _b[judge_male] + _b[judge_def_male]



/* Generate the LaTeX table with esttab */
esttab ols1 ols2 ols3 ols4 ols5 ols6 using "$out\mytable.tex", ///
    replace ///
    keep(judge_male judge_def_male) ///
	label ///
    order("Male Judge on Female Defendant" "Difference = Own Gender Bias") ///
    title("Regression Results") ///
    addnotes("Sample size: `gb_cm_n' (court-month) and `gb_cy_n' (court-year)") ///
    collabels(none) ///
    stats(N Fixed_Effect Demographic_Controls Judge_fixed_effect, labels("Observations" "Fixed Effect" "Demographic Controls" "Judge Fixed Effect")) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    se(%9.3f) /// Round standard errors to three decimal places
    nonumbers ///
    noobs ///
    label varwidth(30) ///

/* Append the sum of coefficients to the LaTeX file */
file open results using "$out/mytable.tex", write text append
file write results _n "\\midrule" ///
                   _n "Male Judge on Male Defendant &  `sum_ols1' & `sum_ols2' & `sum_ols3' & `sum_ols4' & `sum_ols5' & `sum_ols6' \\\\" ///
                   _n "\\bottomrule"
file close results


/*************************/
/* Outcome: Any decision */
/*************************/

/* column 1 */
reghdfe decision judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)


/* column 2 */
reghdfe decision judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts) cluster(judge)


/* column 3 */
reghdfe decision judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts judge) cluster(judge)


/* store sample from column 3 in local */
count if e(sample) == 1
local gb_cm_n = `r(N)'

/* store bias effect for stats csv*/
local gb_cm: di _b["judge_def_male"]


/* column 4 */
reghdfe decision judge_male def_male judge_def_male , absorb(loc_year acts) cluster(judge)


/* column 5 */
reghdfe decision judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts) cluster(judge)

/* column 6 */
reghdfe decision judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts judge) cluster(judge)

/* store sample from column 6 in a local */
count if e(sample) == 1
local gb_cy_n = `r(N)'

/* store bias effect from column 6 in local*/
local gb_cy: di _b["judge_def_male"]


/**************************/
/* Outcome: Not convicted */
/**************************/

/* column 1 */
reghdfe non_convicted judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)

/* column 2 */
reghdfe non_convicted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts) cluster(judge)

/* column 3 */
reghdfe non_convicted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts judge) cluster(judge)

/* column 4 */
reghdfe non_convicted judge_male def_male judge_def_male , absorb(loc_year acts) cluster(judge)

/* column 5 */
reghdfe non_convicted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts) cluster(judge)

/* column 6 */
reghdfe non_convicted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts judge) cluster(judge)


/***************************/
/* Drop ambiguous outcomes */
/***************************/

drop if ambiguous == 1

/* Outcome: Acquitted */

/* column 1 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)

/* column 2 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts) cluster(judge)

/* column 3 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts judge) cluster(judge)

/* column 4 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_year acts) cluster(judge)

/* column 5 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts) cluster(judge)

/* column 6 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts judge) cluster(judge)


/*****************************/
/* Keep only years 2014-2018 */
/*****************************/

use $jdata/justice_analysis, clear

keep if year >= 2014

/* Outcome: Acquitted */

/* column 1 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_month acts) cluster(judge)

/* column 2 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts) cluster(judge)

/* column 3 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_month acts judge) cluster(judge)

/* column 4 */
reghdfe acquitted judge_male def_male judge_def_male , absorb(loc_year acts) cluster(judge)

/* column 5 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts) cluster(judge)

/* column 6 */
reghdfe acquitted judge_male def_male judge_def_male def_nonmuslim judge_men_def_nm , absorb(loc_year acts judge) cluster(judge)





















