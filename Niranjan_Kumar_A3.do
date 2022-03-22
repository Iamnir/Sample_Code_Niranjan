clear all 
cd "D:\MA_Econ\Sem-2\Ecotrix\Assignment\NSS 61\data"

*1.Compute the marginal distribution of caste (SC/ST/OBC/General) and sex (Male, Female) in the individual population.*
*Import the dataset 
use level01.dta, clear 
*STATA saves each dataset into different frame in the kernal then we need to save into a new variable first.* 

save level01.dta, replace 

use level03.dta , clear

*Many to one merge using level01 dataset with level03 dataset 
merge m:1 common_id using level01.dta, keep(match)

*destring converts varlist from string to numeric 

destring sex, replace

*Creating a new variable to replace the values in the variable sex* 
label define Gender 1   "Male" 2   "Female" , replace 

*Use Variable defined above to replace the values* 
label values sex Gender 

*tabulate sex and social_group 
tab sex  
tab social_group 

*2.To find the joint distribution 
tab social_group sex, cell

*3. Now we are going to use the level01 (household dataset)
use level01.dta, clear 
destring mpce_30_days hh_size , replace

*assigning each state a string id which can be used as a string later*

g stateid = substr(state_region,1,2) 

*Again, use dstring to change the string to numeric values* 

destring stateid, replace

*Now we create a new variable per_capita_mpce to calculate per capita mpce 
g per_capita_mpce=mpce_30_days/hh_size
egen per_capita_mpce_mean = mean(per_capita_mpce) , by(stateid)
mean per_capita_mpce, over(stateid)

preserve
duplicates drop stateid, force
*Sort the values and this command in stata works in ascending order 
sort per_capita_mpce_mean
*Top 10 states in terms of consumption per capita  
list stateid per_capita_mpce_mean if inrange(_n, _N - 9, _N) 
restore

*4.We need to calculate deciles of per capita expenditure for households across India.

xtile per_capita_mpce_decile = per_capita_mpce, nq(10)

*Create a new variable to get the min values from per_capita_mpce  by each decile 

egen per_capita_mpce_decile_min = min(per_capita_mpce) , by(per_capita_mpce_decile)

*We calculate the cut-off 
preserve
duplicates drop per_capita_mpce_decile, force
list per_capita_mpce_decile_min
restore
destring common_id, replace
save level01_new.dta, replace 

*5. 
use level04.dta , clear
*Merge using one-to-one with common_id person_srl_no 
merge 1:1 common_id person_srl_no using level03.dta, keep(match)
*destring all the required variables 
destring sex age pri_activity_status, replace
destring common_id, replace
*keep the only data with age 15-59 
keep if inrange(age,15,59)
*generate a new variables  
g employed_po = 0
*now we replace employed_po 
replace employed_po = 1 if inrange(pri_activity_status,11,51)
prtest employed_po, by(sex)

*6. drop _merge

merge m:1 common_id using level01_new.dta

keep if _merge==3

tabulate employed_po per_capita_mpce_decile if sex==2, column chi2


