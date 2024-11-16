*******************************************************************************
// FILE: Replication of Indian-Judicial Bias for Crime against Property offenses 
// Author: Niranjan Kumar 
// Users : Dr. Nirupama Kulkarni, Dr. Abhiman Das 
//
*******************************************************************************


clear all 
set more off 

//$jdata is the folder where datasets are
global jdata "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication"


/* import analysis dataset */
use $jdata/justice_analysis, clear

//keep sections which are related to crime against property 

* Define the list of specific IPC code 
//local section_list "380, 381, 382, 404, 169, 183, 185, 206, 207, 214, 288, 421, 422, 423, 424, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462"

local section_list "169, 184, 185, 206, 207, 208, 380, 381, 382, 403, 404, 409, 421, 422, 423, 424,  443, 444, 445, 446, 461 "

destring section, replace

* Filter the dataset for them 
keep if inlist(section, 169, 184, 185, 206, 207, 208, 380, 381, 382, 403, 404, 409, 421, 422, 423, 424,  443, 444, 445, 446, 461 )

//save the dataset 
save $jdata/justice_analysis_property_crime, replace



//FOR JUSTICE_SAME_LASTNAME 
clear all 
set more off 


//$jdata is the folder where datasets are
global jdata "C:\Users\niranjan.kumar\Desktop\AppraisalGap\Mechanism_Task\P_1\bias_replication"


/* import analysis dataset */
use $jdata/justice_same_names, clear

//keep sections which are related to crime against property 
* Define the list of specific IPC code 
//local section_list "380, 381, 382, 404, 169, 183, 185, 206, 207, 214, 288, 421, 422, 423, 424, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462"

local section_list "169, 184, 185, 206, 207, 208, 380, 381, 382, 403, 404, 409, 421, 422, 423, 424,  443, 444, 445, 446, 461 "

destring section, replace

* Filter the dataset for them 
//keep if inlist(section, 380, 381, 382, 404, 169, 183, 185, 206, 207, 214, 288, 421, 422, 423, 424, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462)

keep if inlist(section, 169, 184, 185, 206, 207, 208, 380, 381, 382, 403, 404, 409, 421, 422, 423, 424,  443, 444, 445, 446, 461 )

//save the dataset 
save $jdata/justice_same_names_property_crime, replace