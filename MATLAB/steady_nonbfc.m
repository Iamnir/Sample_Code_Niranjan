% Solve steady state using all the equations and the solution guess (without nbfcs) 

%NO NBFC 

function steady_nonbfc = steady_nonbfc(x)

parameters_ss;

% Some additional parameters and variables that cancel out in steady state 

a_P = 0.5;
epsilon_c = 1.0;
epsilon_h = 1.0;
inf = pi_bar;
a_I = 0.5;
a_E = 0.5;
z = 1.0;

% Variables

c_P = x(1);
lambda_P = x(2);
h_P = x(3);
q_h = x(4);
w_F = x(5);
w_X = x(6);
n_PF = x(7);
n_PX = x(8);
d_P = x(9);
bank_prof = x(10);
c_I = x(11);
lambda_I = x(12);
n_IF = x(13);
n_IX = x(14);
omega_I = x(15);
r_bI = x(16);
b_bI = x(17);
c_E = x(18);
lambda_E = x(19);
theta_s = x(20);
k_E = x(21);
n_F = x(22);
n_X = x(23);
n = x(24);
r_bE = x(25);
omega_E = x(26);
q_k = x(27);
b_bE = x(28);
y_F = x(29);
y_X = x(30);
y = x(31);
k_b = x(32);
rwa = x(33);
i_k = x(34);
i_h = x(35);
h_I = x(36);
T = x(37);
R_bI = x(38);
R_bE = x(39);

% Patient households block 

steady_nonbfc(1) = (1.0 - a_P) * epsilon_c / (c_P - a_P * c_P) - lambda_P;

steady_nonbfc(2) = epsilon_h / h_P - lambda_P * q_h + beta_P * (lambda_P * (1.0-delta_h) * q_h);

steady_nonbfc(3) = n_PF ^ gamma_lF - lambda_P * (1.0-tau_l) * w_F;

steady_nonbfc(4) = n_PX ^ gamma_lX - lambda_P * w_X;

steady_nonbfc(5) = c_P + q_h * (h_P - (1.0-delta_h) * h_P) + d_P / big_gamma_P - (1.0-tau_l) * w_F * n_PF -...
     w_X * n_PX - (1.0 + r) * d_P / (inf * big_gamma_P) - (1.0-prof_share_b) * bank_prof / big_gamma_P -...
          T/(big_gamma_P + big_gamma_I);

% Impatient households block 

steady_nonbfc(6) = (1.0 - a_I) * epsilon_c / (c_I - a_I * c_I) - lambda_I;

steady_nonbfc(7) = epsilon_h / h_I - lambda_I * q_h + beta_I * (lambda_I * (1.0-delta_h) * q_h);

steady_nonbfc(8) = n_IF ^ gamma_lF - lambda_I * (1.0-tau_l) * w_F;

steady_nonbfc(9) = n_IX ^ gamma_lX - lambda_I * w_X;

steady_nonbfc(10) = lambda_I - beta_I * (1.0 + r_bI) * (lambda_I * omega_I / inf);

steady_nonbfc(11) = c_I + q_h * (h_I - (1.0-delta_h) * h_I) + (1.0+r_bI) * b_bI * omega_I/(inf * big_gamma_I) -...
      (1.0-tau_l) * w_F * n_IF - w_X * n_IX -...
        b_bI / big_gamma_I - T / (big_gamma_P + big_gamma_I);


% Entrepreneur block 

steady_nonbfc(12) = (1.0-a_E) * epsilon_c /(c_E - a_E * c_E) - lambda_E;

steady_nonbfc(13) = beta_E * ((1.0-theta_s * tau_s) *... 
          alpha_s * z * k_E ^ (alpha_s-1.0) * n_F ^ (1.0-alpha_s) * lambda_E +...
          q_k * (1.0-delta_k) * lambda_E) - lambda_E * q_k;

steady_nonbfc(14) = (1.0 - theta_s * tau_s) * (1.0-alpha_s) * z * k_E ^ alpha_s * n_F ^ (-alpha_s) - (1.0+tau_p) * w_F;

steady_nonbfc(15) = (1.0 - theta_s * tau_s) * (1.0-alpha_s) * z * n_X ^ (-alpha_s) - w_X;

steady_nonbfc(16) = lambda_E - beta_E * (1.0 + r_bE) * (lambda_E * omega_E / inf);

steady_nonbfc(17) = c_E + (1.0+tau_p) * w_F * n_F + w_X * n_X + (1.0+r_bE) * b_bE * omega_E /...
        (inf * big_gamma_E) + q_k * (k_E - (1.0-delta_k) * k_E) -... 
        (1.0 - theta_s * tau_s) * (y_F + y_X) - b_bE / big_gamma_E;

steady_nonbfc(18) = y_F - z * k_E ^ alpha_s * n_F ^ (1.0-alpha_s);

steady_nonbfc(19) = y_X - z * n_X ^ (1.0-alpha_s);

steady_nonbfc(20) = y - y_F - y_X;

steady_nonbfc(21) = n_F - (big_gamma_P * n_PF + big_gamma_I * n_IF)/big_gamma_E;

steady_nonbfc(22) = n_X - (big_gamma_P * n_PX + big_gamma_I * n_IX)/big_gamma_E;

steady_nonbfc(23) = n - n_F - n_X;

steady_nonbfc(24) = theta_s - (n_X/n) ^ theta;

% Bank block 

steady_nonbfc(25) = R_bI - prior_prov_I - r + chi_kb * (k_b/rwa - cap_reg) * (k_b/rwa)^2 * risk_wt_I;

steady_nonbfc(26) = R_bE - prior_prov_E - r + chi_kb * (k_b/rwa - cap_reg) * (k_b/rwa)^2 * risk_wt_E;


steady_nonbfc(27) = rwa - risk_wt_I * b_bI - risk_wt_E * b_bE;

steady_nonbfc(28) = omega_I - epsilon_bI/r_bI * ((1.0+r_bI) * omega_I - 1.0 - R_bI) -... 
      chi_rbI * (r_bI/r_bI - 1.0) * r_bI/r_bI * b_bI + beta_P * ...
      lambda_P/lambda_P * inf/inf * (chi_rbI * (r_bI/r_bI - 1.0) * ...
      (r_bI/r_bI)^2 * b_bI);

steady_nonbfc(29) = omega_E - epsilon_bE/r_bE * ((1.0+r_bE) * omega_E - 1.0 - R_bE) -... 
      chi_rbE * (r_bE/r_bE - 1.0) * r_bE/r_bE * b_bE + beta_P * ...
      lambda_P/lambda_P * inf/inf * (chi_rbE * (r_bE/r_bE - 1.0) * ...
      (r_bE/r_bE)^2 * b_bE);


steady_nonbfc(30) = k_b - (1.0-delta_b) * k_b/inf - prof_share_b * bank_prof/inf;

steady_nonbfc(31) = bank_prof - (r_bI * omega_I - theta_b * (1.0 - omega_I) + prior_prov_I) * b_bI/inf -...
            (r_bE * omega_E - theta_b * (1.0 - omega_E) + prior_prov_E) * b_bE/inf + ...
            r * d_P/inf + chi_kb/2 * (k_b/rwa - cap_reg)^2 * k_b + ... 
            chi_rbI/2 * (r_bI/r_bI-1.0)^2 + chi_rbE/2 * (r_bE/r_bE-1.0)^2;



% Capital and housing producers 

steady_nonbfc(32) = q_k * (1.0 - chi_ik/2 * (i_k/i_k - 1)^2) - q_k * chi_ik * (i_k/i_k - 1.0) * ...  
       (i_k/i_k) - 1 + beta_E * lambda_E/lambda_E * q_k * chi_ik * (i_k/i_k - 1.0) * ...
       (i_k/i_k)^2;

steady_nonbfc(33) = q_h * (1.0 - chi_ih/2 * (i_h/i_h - 1)^2) - q_h * chi_ih * (i_h/i_h - 1.0) * ... 
       (i_h/i_h) - 1 + beta_E * lambda_E/lambda_E * q_h * chi_ih * (i_h/i_h - 1.0) * ...
       (i_h/i_h)^2;

% Government 

steady_nonbfc(34) = (big_gamma_P + big_gamma_I) * tau_l * w_F * n_F + big_gamma_E * tau_p * w_F * n_F + ...
       big_gamma_E * theta_s * tau_s * y - T;

% Default 

steady_nonbfc(35) = omega_E - 1;

steady_nonbfc(36) = omega_I - 1; 


% Missed 

steady_nonbfc(37) = k_b + d_P - b_bI - b_bE;

steady_nonbfc(38) = i_k - delta_k * big_gamma_E * k_E;

steady_nonbfc(39) = i_h - delta_h * (big_gamma_P * h_P + big_gamma_I * h_I);
end 
