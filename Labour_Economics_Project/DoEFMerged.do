global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd "$path"

use DoEF5,clear 
merge 1:1 NIC_code using DoEF1 
keep if _merge ==3 
drop _merge 
merge 1:1 NIC_code using DoEF2 
keep if _merge ==3 
drop _merge 
merge 1:1 NIC_code using DoEF3
keep if _merge ==3 
drop _merge 
merge 1:1 NIC_code using DoEF4
keep if _merge ==3 
save DoEFMerged.dta, replace 
univar Average_DOEF