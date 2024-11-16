// Dynare implementation for the simplest model 

var c_P c_I h_P h_I lambda_P lambda_I n_PF n_PX n_IF n_IX d_P r w_F w_X c_E lambda_E k_E q_k infl y p_E i_k q_h i_h T
n_EX n_EF n y_F y_X theta_s z epsilon_c epsilon_h monpol m_I sigma_I b_bI, R_bI r_bI j_b k_b capreg m_E sigma_E b_bE 
r_bE R_bE b_b omega_I omega_E rwa psi_I psi_E b_nI R_n r_nI j_n k_n b_n b_bn r_bn R_bn psi_n omega_n lambda_lim;

varexo e_z e_c e_h e_m e_mI e_capreg e_mE e_omegaI e_omegaE e_psiI e_psiE e_psin e_omegan;

parameters a_P a_I gamma_lF gamma_lX beta_P beta_I big_gamma_P big_gamma_E a_E theta 
          beta_E delta_k delta_h alpha epsilon_f chi_p chi_ik chi_ih pi_bar tau_l tau_p tau_s
          z_bar epsilon_c_bar epsilon_h_bar monpol_bar rho sigma_z sigma_c sigma_h sigma_m 
sigma_mI sigma_mE  sigma_oE sigma_oI sigma_on sigma_pE sigma_pI sigma_pn sigma_cap
 r_bar rho_pi big_gamma_I m_I_bar eta rho_r rho_y delta_b chi_kb capreg_bar p_share_b p_share_n epsilon_bI chi_rI chi_rE epsilon_bE m_E_bar 
       omega_I_bar omega_E_bar psi_I_bar psi_E_bar epsilon_nI epsilon_nE epsilon_bn delta_n
          psi_n_bar omega_n_bar chi_rn chi_rnI chi_rnE param theta_lim;

beta_P = 0.9943;
beta_E = 0.945; 
beta_I = 0.945; 
gamma_lF = 0.5;
gamma_lX = 0.3;
big_gamma_P = 0.6;
big_gamma_E = 0.2;
big_gamma_I = 1 - big_gamma_P - big_gamma_E;
alpha = 0.33;
epsilon_f = 6;
chi_p = 55; //changed from 55 to 9.1301
chi_ik = 55;
chi_ih = 55;
chi_n = 0;
r_bar = 0.04;
pi_bar = beta_P * (1+r_bar);
z_bar = 1;
tau_l = 0.3;
tau_p = 0.2;
tau_s = 0.5;
epsilon_c_bar = 1;
epsilon_h_bar = 1;
monpol_bar = 0;
a_E = 0.5;
a_P = 0.5;
a_I = 0.5;
delta_k = 0.1;
delta_h = 0.1;
rho = 0.4553; //changed 0.6
sigma_z = 0.010;
sigma_c = 0.010;
sigma_h = 0.010;
sigma_m = 0.0270;
sigma_mI= 0.0068;
sigma_mE = 0.0067;
sigma_oE = 0.0068;
sigma_oI = 0.0067;
sigma_on = 0.0066;
sigma_pE = 0.010;
sigma_pI = 0.010; 
sigma_pn = 0.0067;
sigma_cap = 0.0070;
r_bar = r_bar;
rho_pi = 2.0743;  //changed 1.05
theta = 3;
m_I_bar = 0.5;
eta = 0.9;
rho_r = 0.9348; //Changed 0.75
rho_y = -0.0702;   //changed 0.1
delta_b = 0.02;
chi_kb = 2.7339; //changed 55 to 2.7339
capreg_bar = 0.09;
p_share_b = 0.4;
p_share_n = 0.4;
epsilon_bI = 4;
chi_rI = 2.1452; // changed 55 to 2.1452
epsilon_bE = 6;
m_E_bar = 0.5;
chi_rE = 1.8055;  //changed 55 to 1.8055
chi_rn = 2.3971;  //changed 55 to 2.3971
chi_rnI = 2.7075; //changed 55 to 2.7075
chi_rnE = 2.3740; //changed 55 to 2.3740
omega_I_bar = 1.0;
omega_E_bar = 1.0;
omega_n_bar = 1.0;
psi_I_bar = 0.0;
psi_E_bar = 0.0;
psi_n_bar = 0.0;
epsilon_nI = 6;
epsilon_nE = 6;
epsilon_bn = 6;
delta_n = 0.02;
param = 0.2;
theta_lim = 3.5;


model;

// Patient Households 

(1-a_P) * epsilon_c/(c_P - a_P * c_P(-1)) = lambda_P;

n_PF ^ gamma_lF = lambda_P * w_F * (1-tau_l);

n_PX ^ gamma_lX = lambda_P * w_X;

epsilon_h/h_P = q_h * lambda_P - beta_P * q_h(+1) * lambda_P(+1) * (1-delta_h);

lambda_P = beta_P * (1+exp(r)) * lambda_P(+1)/exp(infl(+1));

c_P + q_h * (h_P - (1-delta_h) * h_P(-1)) + d_P/big_gamma_P = (1-tau_l) * w_F * n_PF + 
              w_X * n_PX + (1+exp(r(-1))) * d_P(-1)/(exp(infl) * big_gamma_P) + T/(big_gamma_I + big_gamma_P) +
              p_share_b * j_b(-1) + p_share_n * j_n(-1);

// Impatient households 

(1-a_I) * epsilon_c/(c_I - a_I * c_I(-1)) = lambda_I;

n_IF ^ gamma_lF = lambda_I * w_F * (1-tau_l) + lambda_lim * theta_lim * (1 - tau_l) * w_F;

n_IX ^ gamma_lX = lambda_I * w_X + lambda_lim * theta_lim * w_X;

epsilon_h/h_I = q_h * lambda_I - beta_I * q_h(+1) * lambda_I(+1) * (1-delta_h) - 
                   sigma_I * m_I * q_h(+1) * (1-delta_h) * exp(infl(+1));

lambda_I = beta_I * (1+r_bI) * lambda_I(+1)/exp(infl(+1)) + sigma_I * (1+r_bI) + lambda_lim * (1 + r_bI);

lambda_I = beta_I * (1 + r_nI)  * lambda_I(+1)/exp(infl(+1)) + lambda_lim * (1 + r_nI);

(1 + r_bI) * b_bI/big_gamma_I + (1 + r_nI) * b_nI/big_gamma_I = theta_lim * ((1 - tau_l) * w_F * n_IF + w_X * n_IF);

m_I * q_h(+1) * (1-delta_h) * h_I * exp(infl(+1)) = (1+r_bI) * b_bI/big_gamma_I;

c_I + q_h * (h_I - (1-delta_h) * h_I(-1)) + (1+r_bI(-1)) * b_bI(-1)/(exp(infl) * big_gamma_I) + 
(1+r_nI(-1)) * b_nI(-1)/(exp(infl) * big_gamma_I) = (1-tau_l) * w_F * n_IF + 
                                 w_X * n_IX  + b_bI/big_gamma_I + b_nI/big_gamma_I + T/(big_gamma_I + big_gamma_P);

// Entrepreneurs

(1-a_E) * epsilon_c/(c_E - a_E * c_E(-1)) = lambda_E;

lambda_E * q_k = beta_E * q_k(+1) * (1-delta_k) * lambda_E(+1) +
                  beta_E * (1 - theta_s(+1) * tau_s) * lambda_E(+1) * alpha * z(+1) * 
                  k_E^(alpha-1) * n_EF(+1)^(1-alpha) * p_E(+1) + 
                  sigma_E * m_E * q_k(+1) * (1-delta_k) * exp(infl(+1));

lambda_E = beta_E * (1+r_bE) * lambda_E(+1)/exp(infl(+1)) + sigma_E * (1+r_bE);

m_E * q_k(+1) * (1-delta_k) * k_E * exp(infl(+1)) = (1+r_bE) * b_bE/big_gamma_E;

(1-theta_s * tau_s) * (1-alpha) * p_E * z * k_E(-1)^alpha * n_EF^(-alpha) = w_F * (1+tau_p);

(1-theta_s * tau_s) * (1-alpha) * p_E * z * n_EX^(-alpha) = w_X;

big_gamma_P * n_PF + big_gamma_I * n_IF = big_gamma_E * n_EF;

big_gamma_P * n_PX + big_gamma_I * n_IX = big_gamma_E * n_EX;

n = big_gamma_E * (n_EX + n_EF);

theta_s = ((big_gamma_E * n_EX)/n)^theta;

y_F = z * k_E(-1)^alpha * n_EF^(1-alpha);

y_X = z * n_EX^(1-alpha);

exp(y) = y_F + y_X;

// Final good producers

p_E = (epsilon_f-1)/epsilon_f + chi_p/epsilon_f * ((exp(infl) - exp(infl(-1)) ^ eta * pi_bar ^ (1-eta)) * exp(infl) -
                   beta_E * lambda_E(+1)/lambda_E * y(+1)/y * (exp(infl(+1)) - exp(infl) ^ eta * pi_bar ^ (1-eta)) * exp(infl(+1)));

// Banks

exp(b_b) = b_bI + b_bE + b_bn;

rwa = omega_I * b_bI + omega_E * b_bE + omega_n * b_bn;

R_bI = psi_I + exp(r) - chi_kb * (k_b/rwa - capreg) * (k_b/rwa)^2 * omega_I;

R_bE = psi_E + exp(r) - chi_kb * (k_b/rwa - capreg) * (k_b/rwa)^2 * omega_E;

R_bn = psi_n + exp(r) - chi_kb * (k_b/rwa - capreg) * (k_b/rwa)^2 * omega_n;

epsilon_bI - 1 = epsilon_bI * R_bI/r_bI - chi_rI * (r_bI/r_bI(-1) - 1) * r_bI/r_bI(-1) +
                   beta_P * (lambda_P(+1)/lambda_P * exp(infl(+1))/exp(infl) * chi_rI * (r_bI(+1)/r_bI - 1) * (r_bI(+1)/r_bI)^2 * b_bI(+1)/b_bI);

epsilon_bE - 1 = epsilon_bE * R_bE/r_bE - chi_rE * (r_bE/r_bE(-1) - 1) * r_bE/r_bE(-1) +
                   beta_P * (lambda_P(+1)/lambda_P * exp(infl(+1))/exp(infl) * chi_rE * (r_bE(+1)/r_bE - 1) * (r_bE(+1)/r_bE)^2 * b_bE(+1)/b_bE);

epsilon_bn - 1 = epsilon_bn * R_bn/r_bn - chi_rn * (r_bn/r_bn(-1) - 1) * r_bn/r_bn(-1) +
                   beta_P * (lambda_P(+1)/lambda_P * exp(infl(+1))/exp(infl) * chi_rn * (r_bn(+1)/r_bn - 1) * (r_bn(+1)/r_bn)^2 * b_bn(+1)/b_bn);


k_b = (1 - delta_b) * k_b(-1)/exp(infl)  + (1 - p_share_b) * j_b(-1)/exp(infl);

j_b = r_bI * b_bI + r_bE * b_bE - exp(r) * d_P - chi_kb/2 * (k_b/rwa - capreg)^2 * k_b 
                      - chi_rI/2 * (r_bI/r_bI(-1) - 1)^2 * r_bI * b_bI
                      - chi_rE/2 * (r_bE/r_bE(-1) - 1)^2 * r_bE * b_bE
                      - chi_rn/2 * (r_bn/r_bn(-1) - 1)^2 * r_bn * b_bn;

b_bI + b_bE + b_bn = k_b + d_P;


// NBFC 

b_n = b_bn + k_n;

b_n = b_nI;

R_n = r_bn;

epsilon_nI - 1 = epsilon_nI * R_n/r_nI - chi_rnI * (r_nI/r_nI(-1) - 1) * r_nI/r_nI(-1) +
                   beta_P * (lambda_P(+1)/lambda_P * exp(infl(+1))/exp(infl) * chi_rnI * (r_nI(+1)/r_nI - 1) * (r_nI(+1)/r_nI)^2 * b_nI(+1)/b_nI);

k_n = (1 - delta_n) * k_n(-1)/exp(infl)  + (1 - p_share_n) * j_n(-1)/exp(infl);

j_n = r_nI * b_nI - r_bn * b_bn -chi_rnI/2 * (r_nI/r_nI(-1) - 1)^2 * r_nI * b_nI;


// Resource constraint

big_gamma_P * c_P + big_gamma_I * c_I + big_gamma_E * c_E + i_k + i_h + delta_b * k_b + delta_n * k_n 
         + chi_kb/2 * (k_b/rwa - capreg)^2 * k_b
         + chi_rI/2 * (r_bI/r_bI(-1) - 1)^2 * r_bI * b_bI
         + chi_rE/2 * (r_bE/r_bE(-1) - 1)^2 * r_bE * b_bE
         + chi_rn/2 * (r_bn/r_bn(-1) - 1)^2 * r_bn * b_bn
         + chi_rnI/2 * (r_nI/r_nI(-1) - 1)^2 * r_nI * b_nI =
          big_gamma_E * exp(y)- chi_p/2  * (exp(infl) - exp(infl(-1)) ^ eta * pi_bar ^ (1-eta))^2 * big_gamma_E * exp(y);
                                   

// Capital and housing


q_k * (1 - chi_ik/2 * (i_k/i_k(-1) - 1)^2) - 1 = (q_k * chi_ik * (i_k/i_k(-1) - 1) * 1/i_k(-1)) * i_k - 
                      beta_E * lambda_E(+1)/lambda_E * (q_k(+1) * chi_ik * (i_k(+1)/i_k - 1) * i_k(+1)/(i_k^2)) * i_k(+1);

i_k = big_gamma_E * (k_E - (1-delta_k)*k_E(-1)) + chi_ik/2 * (i_k/i_k(-1) - 1)^2 * i_k;

q_h * (1 - chi_ih/2 * (i_h/i_h(-1) - 1)^2) - 1 = (q_h * chi_ih * (i_h/i_h(-1) - 1) * 1/i_h(-1)) * i_h - 
                      beta_E * lambda_E(+1)/lambda_E * (q_h(+1) * chi_ih * (i_h(+1)/i_h - 1) * i_h(+1)/(i_h^2)) * i_h(+1);

i_h = big_gamma_P * h_P + big_gamma_I * h_I 
                                  - (1-delta_h) * (big_gamma_P * h_P(-1) + big_gamma_I * h_I(-1))
                                  + chi_ih/2 * (i_h/i_h(-1) - 1)^2 * i_h; 
                                  

// Central bank

 (1+exp(r)) = (1+r_bar) ^ (1-rho_r) * (1+exp(r(-1))) ^ rho_r * (exp(infl)/pi_bar) ^ (rho_pi * (1-rho_r)) * 
                                    (exp(y)/exp(y(-1))) ^ (rho_y * (1-rho_r)) * exp(monpol);



// Government

(big_gamma_P * n_PF + big_gamma_I * n_IF) * tau_l * w_F + big_gamma_E * tau_p * w_F * n_EF 
                                    + theta_s * tau_s * p_E * big_gamma_E * exp(y) = T;

// Shocks

z = (1-rho) * z_bar + rho * z(-1) + sigma_z * e_z;

epsilon_c = (1-rho) * epsilon_c_bar + rho * epsilon_c(-1) + sigma_c * e_c;

epsilon_h = (1-rho) * epsilon_h_bar + rho * epsilon_h(-1) + sigma_h * e_h;

monpol = (1-rho) * monpol_bar + rho * monpol(-1) + sigma_m * e_m;

m_I = (1-rho) * m_I_bar + rho * m_I(-1) + sigma_mI* e_mI;

capreg = (1-rho) * capreg_bar + rho * capreg(-1) + sigma_cap * e_capreg;

m_E = (1-rho) * m_E_bar + rho * m_E(-1) + sigma_mE * e_mE;

omega_E = (1-rho) * omega_E_bar + rho * omega_E(-1) + sigma_oE * e_omegaE;

omega_I = (1-rho) * omega_I_bar + rho * omega_I(-1) + sigma_oI * e_omegaI;

omega_n = (1-rho) * omega_n_bar + rho * omega_n(-1) + sigma_on * e_omegan;

psi_E = (1-rho) * psi_E_bar + rho * psi_E(-1) + sigma_pE * e_psiE;

psi_I = (1-rho) * psi_I_bar + rho * psi_I(-1) + sigma_pI * e_psiI;

psi_n = (1-rho) * psi_n_bar + rho * psi_n(-1) + sigma_pn * e_psin;


end;

initval;

c_P = 0.51;
c_E = 0.79;
c_I = 0.50;
lambda_P = 1.93;
lambda_E = 1.26;
lambda_I = 1.98;
h_P = 4.90;
h_I = 4.20;
r = log(r_bar);
d_P = 1.39;
T = 0.19;
n_PF = 0.66;
n_PX = 0.79;
n_IF = 0.69;
n_IX = 0.85;
n_EF = 1.00;
n_EX = 1.21;
n = 0.89;
k_E = 2.81;
w_F = 0.59;
w_X = 0.48;
p_E = 0.83;
z = 1.0;
epsilon_c = 1.0;
monpol = 0.0;
infl =log(pi_bar);
i_k = delta_k * big_gamma_E * k_E;
q_k = 1.0;
q_h = 1.0;
i_h = delta_h * (big_gamma_P * h_P + big_gamma_I * h_I);
theta_s = 0.16;
y_F = 1.41;
y_X = 1.14;
y = log(y_F + y_X);
sigma_I = 0.07;
b_bI = 0.59;
m_I = 0.8;
capreg = 0.09;
k_b = 0.135;
R_bI = 0.040;
r_bI = 0.048;
j_b = 0.012;
b_bE = 0.79;
b_b = log(1.53);
sigma_E = 0.050;
m_E = 0.8;
R_bE = 0.040;
r_bE = 0.048;
rwa = b_b;
omega_I = 1;
omega_E = 1;
omega_n = 1;
psi_I = 0;
psi_E = 0;
psi_n = 0;
b_nI = 0.27;
R_n = 0.054;
R_bn = 0.04;
r_nI = 0.072;
r_bn = 0.054;
b_n = b_nI;
lambda_lim = 0.3;


end;

shocks;

var e_c;
stderr 0;
var e_h;
stderr 0;
var e_z;
stderr 0; 
var e_m;
stderr 0.0926; 
var e_mI;
stderr 0;
var e_mE;
stderr 0;
var e_capreg;
stderr 0; 
var e_omegaI;
stderr 0; 
var e_omegaE;
stderr 0;
var e_omegan;
stderr 0;
var e_psiE;
stderr 0;
var e_psiI = 0; 
var e_psin = 0; 
end;


steady;

stoch_simul(order=1, irf = 20, nograph);