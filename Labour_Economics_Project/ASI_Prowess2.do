clear

global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd $path 

ls 

use 201516_m.dta, clear 

***Drop not used variables from ASI ***	

drop DISTRICT_CD STATE_CD NON_MANUF_DAYS NO_OF_UNITS MANUF_DAYS TOT_WORK_DAY PROD_COST


**Get the average number of worker (formal, contractual and total) working in a particular industry (based on NIC Code) ***
collapse (mean) AveWorker1 AveWorker2 AveWorker3 AveWorker4 AveWorker5 AveWorker6 AveWorker7 AveWorker8 AveWorker9, by(industry_code_5)


**Create the share of average contractual Worker in an industry**
gen Share_Contract_Worker = AveWorker4/AveWorker5

**Create the share of average formal worker in an industry** 

gen Share_Formal_Worker = AveWorker3/AveWorker5

**Create NIC Code in same datatype** 
gen str5 NIC_Code = string(industry_code_5,"%05.0f") 

**Save the ASI data with another name** 
save FINALASI.dta, replace 

**Now import Prowess File** 

use Prowess_2017Q2M.dta, clear

drop industry_code_5
*gen NIC_Code = industry_code_5

**merge with prowess** 

merge m:1 NIC_Code using "FINALASI.dta"

**drop not useful data** 

drop short_name entity_type_code owner_code owner_gp_name co_industry_type co_industry_gp_code siq_company_name siq_interim_info_type siq_ntrm_months siq_ntrm_source 

*rename variables** 
rename siq_ntrm_total_inc total_inc
rename  siq_ntrm_total_exp total_exp
rename siq_ntrm_wages_salaries wages
rename siq_ntrm_net_sales  netSales 
rename siq_ntrm_net_fixed_assets net_FixedAssets

**clean the variables** 
foreach v of varlist total_exp total_inc wages netSales net_FixedAssets{
	 quietly replace `v' = "0" if (`v' == "NA")
}

**change the datatype**
destring total_inc, replace 
destring total_exp, replace 
destring wages, replace 
destring netSales, replace 
destring net_FixedAssets, replace 


rename mr_entity_type_name ownership 

replace ownership = "1" if ownership =="Public Ltd."
replace ownership = "0" if ownership =="Private Ltd."


*subtract 3 months since it is not taking the financial year quarter into account* 

gen year = string(year(date))
gen quarter = quarter(dofq(time))-1

replace quarter= 4 if quarter ==0 

destring year, replace
 
replace year = year-1 if quarter==4

**year-quarter**
gen yq = yq(year, quarter)

format yq %tq


***Take the data from 2015Q1 to 2017Q1 and run the regression**

*keep only merged dataset** 
keep if _merge ==3

*generate another yearly quarter variable** 
gen yq2 = yq 

destring yq2, replace 

**Generate a dummy treatment variable**
gen post = .
tab yq2
keep if year >= 2015 

replace post = 0 if yq2<=225 
replace post = 1 if yq2 >225

save "merged.dta", replace 

**Now run the regression***









