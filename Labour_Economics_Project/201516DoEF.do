global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd "$path"


use 201516A, clear 



keep DSL IND_CD PROD_COST

destring DSL, replace 
destring IND_CD, replace 
save 201516A.dta, replace

/*Use the Block E data of ASI 2017-17 */ 
use 201516D, clear 

reshape wide OpeningRs ClosingRs, i(DSL) j(S_No) 

*create Cash in Hand to Total Current Assets from Block D* 
merge 1:1 DSL using "201516A.dta"

keep if _merge ==3

collapse (sum) OpeningRs17 OpeningRs16, by(IND_CD) 
gen NIC_code = IND_CD 
drop if NIC_code ==. 
tostring NIC_code, replace 
gen share_Cash_To_Current_Assets1516 = OpeningRs17/OpeningRs16
sort NIC_code 
save DoEF5.dta, replace
 
