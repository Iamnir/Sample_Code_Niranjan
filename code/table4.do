*******************************************************************************
// FILE: Replication of Indian-Judicial Bias for Crime against Property offenses 
// Author: Niranjan Kumar 
// Users : Dr. Nirupama Kulkarni, Dr. Abhiman Das 
*******************************************************************************


/* clear any existing globals, programs, data to make sure they don't clash */
clear all
/* set the following globals:
$out: path where output files will be created
$repdata: path to initial data inputs 
$tmp: intermediate data files will be put here
$jcode: path to folder of build and analysis .do and .py files*/

global out "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property\results"
global jdata "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property"
global tmp   "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property\temp"
global jcode "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property\code"
global STATATEX_PATH "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property\stata-tex"

 /* import analysis dataset */
use $jdata/justice_analysis_property_crime, clear


adopath + "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\judicial_bias_replication_property\ado"


/**********************/
/* Outcome: Acquitted */
/**********************/


/* column 1 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim , absorb(loc_month acts) cluster(judge)
store_religion_property, name("col1") outcome("acquitted") label("Acquittal rate")


/* column 2 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_month acts) cluster(judge)
store_religion_property, name("col2") outcome("acquitted") label("Acquittal rate")


/* column 3 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_month acts judge) cluster(judge)
store_religion_property, name("col3") outcome("acquitted") label("Acquittal rate")


/* store sample from column 3 in local */
count if e(sample) == 1
local rb_cm_n = `r(N)'

/* store bias effect from column 3 in local*/
local rb_cm: di _b["judge_def_nonmuslim"]
store_property_data `rb_cm' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias acquittal - court-month: coef") group("main bias results")  

/* store sample */
store_property_data `rb_cm_n' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias acquittal - court-month: sample") group("main bias results")  

/* column 4 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim , absorb(loc_year acts) cluster(judge)
store_religion_property, name("col4") outcome("acquitted") label("Acquittal rate")


/* column 5 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_year acts) cluster(judge)
store_religion_property, name("col5") outcome("acquitted") label("Acquittal rate")


/* column 6 */
reghdfe acquitted judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_year acts judge) cluster(judge)
store_religion_property, name("col6") outcome("acquitted") label("Acquittal rate")
/* store sample from column 6 in local */
count if e(sample) == 1
local rb_cy_n = `r(N)'

/* store bias effect from column 6 in local*/
local rb_cy: di _b["judge_def_nonmuslim"]

/* write bias effect from column 6 in stats csv */
store_property_data `rb_cy' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias acquittal - court-year: coef") group("main bias results")  

/* store sample from column 6 in stats csv */
store_property_data `rb_cy_n' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias acquittal - court-year: sample") group("main bias results")  

/* write regression table */
table_from_tpl, t($jcode\tpl\r_tpl.tex) r($tmp\religion_acquitted.csv) o($out\JBtable4_1.religion_acquitted_New.tex)






/*************************/
/* Outcome: Any decision */
/*************************/

/* column 1 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim , absorb(loc_month acts) cluster(judge)
store_religion_property, name("col1") outcome("decision") label("Decision within six months of filing")

/* column 2 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_month acts) cluster(judge)
store_religion_property, name("col2") outcome("decision") label("Decision within six months of filing")


/* column 3 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_month acts judge) cluster(judge)
store_religion_property, name("col3") outcome("decision") label("Decision within six months of filing")


/* store sample from column 3 in local */
count if e(sample) == 1
local rb_cm_n = `r(N)'

/* store bias effect from column 3 in local*/
local rb_cm: di _b["judge_def_nonmuslim"]

/* write sample from col 3 in stats csv */
store_property_data `rb_cm' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias decision - court-month: coef") group("main bias results")  

/* write sample from col 3 in stats csv */
store_property_data `rb_cm_n' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias decision - court-month: sample") group("main bias results") 
 
/* column 4 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim , absorb(loc_year acts) cluster(judge)
store_religion_property, name("col4") outcome("decision") label("Decision within six months of filing")


/* column 5 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_year acts) cluster(judge)
store_religion_property, name("col5") outcome("decision") label("Decision within six months of filing")


/* column 6 */
reghdfe decision judge_nonmuslim def_nonmuslim judge_def_nonmuslim def_male judge_nm_def_men , absorb(loc_year acts judge) cluster(judge)
store_religion_property, name("col6") outcome("decision") label("Decision within six months of filing")


/* store sample from col 6 in local */
count if e(sample) == 1
local rb_cy_n = `r(N)'

/* store bias effect from col 6 in local */
local rb_cy: di _b["judge_def_nonmuslim"]

/* write bias coef from col 6 in stats csv */
store_property_data `rb_cy' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias decision - court-year: coef") group("main bias results")  

/* store sample from col 6 in stats csv */
store_property_data `rb_cy_n' using $out\justice_paper_stats.csv, timestamp("$property_logtime") test_type("Religion bias decision - court-year: sample") group("main bias results")  

/* write regression table */
table_from_tpl, t($jcode\tpl\r_tpl.tex) r($tmp\religion_decision.csv) o($out\JBtable4_2.religion_decision_New.tex)




