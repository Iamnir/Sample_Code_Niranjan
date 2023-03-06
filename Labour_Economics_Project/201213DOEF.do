global path "D:\MA_Econ\Sem-3\Labour_Economics"

cd "$path"


use 201213A, clear 

*keep if Statusofunit ==1 

keep DSL NIC5digit CostofProd

save 201213A.dta, replace
*Now to merge with the Cash to Assets* 
use 201213D, clear 

reshape wide WorkCapOp WorkCapCl, i(DSL) j(Sno) 

*create Cash in Hand to Total Current Assets from Block D* 
merge 1:1 DSL using "201213A.dta"

keep if _merge ==3

collapse (sum) WorkCapOp16 WorkCapOp17, by(NIC5digit) 
gen NIC_code = NIC5digit
drop if NIC_code ==. 

tostring NIC_code, replace 
gen share_Cash_To_Current_Assets1213 =  WorkCapOp17/WorkCapOp16
save DoEF3.dta, replace
 
