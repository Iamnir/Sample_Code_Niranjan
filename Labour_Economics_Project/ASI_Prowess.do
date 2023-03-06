clear

global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd $path 

use Prowess_2017Q2M.dta, clear

drop short_name entity_type_code owner_code owner_gp_name co_industry_type co_industry_gp_code siq_company_name siq_interim_info_type siq_ntrm_months siq_ntrm_source 


gen total_inc = siq_ntrm_total_inc
gen total_exp = siq_ntrm_total_exp
gen wages = siq_ntrm_wages_salaries
gen netSales = siq_ntrm_net_sales 
gen net_FixedAssets = siq_ntrm_net_fixed_assets

drop siq_ntrm_total_exp siq_ntrm_total_inc siq_ntrm_wages_salaries siq_ntrm_net_sales siq_ntrm_net_fixed_assets

foreach v of varlist total_exp total_inc wages netSales net_FixedAssets{
	 quietly replace `v' = "0" if (`v' == "NA")
}

destring total_inc, replace 
destring total_exp, replace 
destring wages, replace 

destring netSales, replace 
destring net_FixedAssets, replace 

gen wages_Share_in_NS = wages/netSales 
quietly replace wages_Share_in_NS = 0 if (wages_Share_in_NS== .)

rename mr_entity_type_name ownership 

replace ownership = "1" if ownership =="Public Ltd."
replace ownership = "0" if ownership =="Private Ltd."


*subtract 3 months since it is not taking the financial year quarter into account* 

gen year = string(year(date))
gen quarter = quarter(dofq(time))-1

replace quarter= 4 if quarter ==0 

destring year, replace
 
replace year = year-1 if quarter==4

gen yq = yq(year, quarter)

format yq %tq


 


merge m:1 NIC_Code using "mergedASI2.dta"

keep if _merge ==3

gen yq2 = yq 

destring yq2, replace 

gen post = .
tab yq2
keep if year >= 2015 

replace post = 0 if yq2<=225 
replace post = 1 if yq2 >225

drop _merge 
merge m:1 NIC_Code using "DoEFMerged.dta"
save "Final2.dta", replace
