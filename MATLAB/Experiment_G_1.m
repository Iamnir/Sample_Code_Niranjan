%%%Experiment Analysis - IRFs and Simultaneous Shocks 
p_c_P = 1 ; 
p_c_I = 2;
p_h_P = 3; 
p_h_I = 4; 
p_lambda_P = 5; 
p_lambda_I = 6;
p_n_PF  =7; 
p_n_PX  = 8; 
p_n_IF  = 9; 
p_n_IX  = 10; 
p_d_P   = 11; 
p_r     = 12; 
p_w_F   = 13; 
p_w_X   = 14; 
p_c_E   = 15; 
p_lambda_E = 16; 
p_k_E     = 17; 
p_q_k     = 18; 
p_infl    = 19; 
p_y       = 20; 
p_p_E     = 21; 
p_i_k     = 22; 
p_q_h     = 23;
p_i_h     = 24; 
p_T       = 25; 
p_n_EX    = 26; 
p_n_EF    = 27; 
p_n       = 28; 
p_y_F     = 29; 
p_y_X     = 30; 
p_theta_s = 31; 
p_z       = 32; 
p_epsilon_c = 33;
p_epsilon_h = 34; 
p_monpol  = 35;
p_m_I     = 36; 
p_sigma_I    = 37;  
p_b_bI      = 38; 
p_R_bI      = 39; 
p_r_bI      = 40; 
p_j_b       = 41; 
p_k_b       = 42; 
p_capreg    = 43;
p_m_E       = 44; 
p_sigma_E   = 45; 
p_b_bE      = 46;
p_r_bE      = 47;
p_R_bE      = 48; 
p_b_b       = 49; 
p_omega_I   = 50; 
p_omega_E   = 51; 
p_rwa       = 52; 
p_psi_I     = 53; 
p_psi_E     = 54; 
p_b_nI      = 55; 
p_R_n       = 56; 
p_r_nI      = 57; 
p_j_n       = 58; 
p_k_n       = 59; 
p_b_n       = 60; 
p_b_bn      = 61; 
p_r_bn      = 62; 
p_R_bn      = 63; 
p_psi_n     = 64;  
p_omega_n   = 65; 
p_lambda_lim = 66;

%% State Space Representation : S(t) = A*S(t-1) + B*e(t), X(t) = C*S(t-1) + D*e(t) 

%Define the state variables - Get the order of the state variables
A = [oo_.dr.ghx(oo_.dr.inv_order_var(p_c_P), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_c_I), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_h_P), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_h_I), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_d_P), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_r), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_c_E), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_k_E), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_epsilon_c), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_epsilon_h), :);
     oo_.dr.ghx(oo_.dr.inv_order_var(p_monpol), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_m_I), :);
     oo_.dr.ghx(oo_.dr.inv_order_var(p_j_b), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_k_b), :);
     oo_.dr.ghx(oo_.dr.inv_order_var(p_capreg), :) ; oo_.dr.ghx(oo_.dr.inv_order_var(p_m_E), :);
     oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_I), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_E), :);
     oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_I), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_E), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_j_n), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_k_n), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_n), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_n), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_infl), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_y), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_i_k), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_i_h), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_z), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_b_bI), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bI), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bE), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_b_nI), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_r_nI), :);
      oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bn), :);
      ]; 
 
%Get the coefficients on the shocks parameters 
B = [oo_.dr.ghu(oo_.dr.inv_order_var(p_c_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_c_I), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_h_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_h_I), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_d_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_r), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_c_E), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_k_E), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_epsilon_c), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_epsilon_h), :);
     oo_.dr.ghu(oo_.dr.inv_order_var(p_monpol), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_m_I), :);
     oo_.dr.ghu(oo_.dr.inv_order_var(p_j_b), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_k_b), :);
     oo_.dr.ghu(oo_.dr.inv_order_var(p_capreg), :) ; oo_.dr.ghu(oo_.dr.inv_order_var(p_m_E), :);
     oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_I), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_E), :);
     oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_I), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_E), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_j_n), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_k_n), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_n), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_n), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_infl), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_y), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_i_k), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_i_h), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_z), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_b_bI), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bI), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bE), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_b_nI), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_r_nI), :);
      oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bn), :);
      ]; 
 

C = [oo_.dr.ghx(oo_.dr.inv_order_var(p_lambda_P), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_lambda_I), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_n_PF), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_n_PX), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_n_IF), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_n_IX), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_w_F), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_w_X), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_lambda_E), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_q_k), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_p_E), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_q_h), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_T), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_n_EX), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_n_EF), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_n), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_y_F), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_y_X), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_theta_s), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_sigma_I), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_R_bI), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_sigma_E), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_b_bE), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_R_bE), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_b_b), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_rwa), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_R_n), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_b_n), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_b_bn), :);  oo_.dr.ghx(oo_.dr.inv_order_var(p_R_bn), :); 
    oo_.dr.ghx(oo_.dr.inv_order_var(p_lambda_lim), :)]; 

D = [oo_.dr.ghu(oo_.dr.inv_order_var(p_lambda_P), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_lambda_I), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_n_PF), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_n_PX), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_n_IF), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_n_IX), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_w_F), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_w_X), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_lambda_E), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_q_k), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_p_E), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_q_h), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_T), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_n_EX), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_n_EF), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_n), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_y_F), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_y_X), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_theta_s), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_sigma_I), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_R_bI), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_sigma_E), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_b_bE), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_R_bE), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_b_b), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_rwa), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_R_n), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_b_n), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_b_bn), :);  oo_.dr.ghu(oo_.dr.inv_order_var(p_R_bn), :); 
    oo_.dr.ghu(oo_.dr.inv_order_var(p_lambda_lim), :)  ]; 


%% Compute the impulse responses by Hand 
%% Given data
% Replace values below threshold with 0 in matrix B
%threshold = 1e-7;  % Set the threshold value

%B(abs(B) < threshold) = 0;

H = 20;
Sirf_con = zeros(35, H);
Xirf_con= zeros(31, H);

shock_1 = [0; 10.0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'omega_I', 'omega_E', 'psi_I', 'psi_E', 'psi_n', 'Omega_n'};

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf_con(:, 1) = B * shock_1;
Xirf_con(:, 1) = D * shock_1;

for j = 2:H
    Sirf_con(:, j) = A * Sirf_con(:, j-1);
    Xirf_con(:, j) = C * Sirf_con(:, j-1);
end

Sirf_pn = zeros(35, H); 
Xirf_pn = zeros(31, H);

shock_2 = [0; 10.0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1.4925; 0];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'omega_I', 'omega_E', 'psi_I', 'psi_E', 'psi_n', 'Omega_n'};

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf_pn(:, 1) = B * shock_2;
Xirf_pn(:, 1) = D * shock_2;

for j = 2:H
    Sirf_pn(:, j) = A * Sirf_pn(:, j-1);
    Xirf_pn(:, j) = C * Sirf_pn(:, j-1);
end


Sirf_pE = zeros(35, H); 
Xirf_pE = zeros(31, H);

shock_3 = [0; 10.0; 0; 0; 0; 0; 0; 0; 0; 0; 1.0; 1.4925; 0];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'omega_I', 'omega_E', 'psi_I', 'psi_E', 'psi_n', 'Omega_n'};

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf_pE(:, 1) = B * shock_3;
Xirf_pE(:, 1) = D * shock_3;

for j = 2:H
    Sirf_pE(:, j) = A * Sirf_pE(:, j-1);
    Xirf_pE(:, j) = C * Sirf_pE(:, j-1);
end



Sirf_pI = zeros(35, H); 
Xirf_pI = zeros(31, H);

shock_4 = [0; 10.0; 0; 0; 0; 0; 0; 0; 0; 1.0; 1.0; 1.4925; 0];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'omega_I', 'omega_E', 'psi_I', 'psi_E', 'psi_n', 'Omega_n'};

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf_pI(:, 1) = B * shock_4;
Xirf_pI(:, 1) = D * shock_4;

for j = 2:H
    Sirf_pI(:, j) = A * Sirf_pI(:, j-1);
    Xirf_pI(:, j) = C * Sirf_pI(:, j-1);
end


Sirf_mon = zeros(35, H); 
Xirf_mon = zeros(31, H);

shock_5 = [0; 10.0; 0; 0.0370; 0; 0; 0; 0; 0; 1.0; 1.0; 1.4925; 0];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'omega_I', 'omega_E', 'psi_I', 'psi_E', 'psi_n', 'Omega_n'};

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf_mon(:, 1) = B * shock_5;
Xirf_mon(:, 1) = D * shock_5;

for j = 2:H
    Sirf_mon(:, j) = A * Sirf_mon(:, j-1);
    Xirf_mon(:, j) = C * Sirf_mon(:, j-1);
end


