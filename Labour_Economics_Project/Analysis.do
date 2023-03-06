clear

global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd $path 

ls 

use merged.dta, clear 

tab post yq

/* Plot average salary paid by a firm in a quarter 

mean wages, over(yq) 

quietly anova wages yq

margins yq

marginsplot, noci ytitle(Mean wages) */



**post == treatment dummy and Share_Contract_Worker is a continuous variable** 

reghdfe wages i.post##c.Share_Contract_Worker, absorb(i.co_code i.yq) vce(cluster NIC)


**lower the sample size** 

use merged.dta, clear 
keep if yq2>=223 & yq2<=227
reghdfe wages i.post##c.Share_Contract_Worker, absorb(i.co_code i.yq) vce(cluster NIC)

**How to create a Cash dependency/external_finance dummy** 
reghdfe wages i.post##i.DOEF##c.Share_Contract_Worker, absorb(i.co_code i.yq) vce(cluster NIC)
**exploit that channel** 
use merged.dta, clear 
keep if yq2>=223 & yq2<=227
reghdfe wages i.post##i.DOEF##c.Share_Contract_Worker, absorb(i.co_code i.yq) vce(cluster NIC)

**For Robustness, ask for any suggestions** 
