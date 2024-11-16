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
     oo_.dr.ghx(oo_.dr.inv_order_var(p_j_b), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_k_b), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_capreg), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_m_E), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_I), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_E), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_I), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_E), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_j_n), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_k_n), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_psi_n), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_omega_n), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_infl), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_y), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_i_k), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_i_h), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_z), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_b_bI), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bI), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bE), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_b_nI), :); oo_.dr.ghx(oo_.dr.inv_order_var(p_r_nI), :); 
     oo_.dr.ghx(oo_.dr.inv_order_var(p_r_bn), :) ]; 
 

 B = [oo_.dr.ghu(oo_.dr.inv_order_var(p_c_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_c_I), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_h_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_h_I), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_d_P), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_r), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_c_E), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_k_E), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_epsilon_c), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_epsilon_h), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_monpol), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_m_I), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_j_b), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_k_b), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_capreg), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_m_E), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_I), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_E), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_I), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_E), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_j_n), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_k_n), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_psi_n), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_omega_n), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_infl), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_y), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_i_k), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_i_h), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_z), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_b_bI), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bI), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bE), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_b_nI), :); oo_.dr.ghu(oo_.dr.inv_order_var(p_r_nI), :); 
     oo_.dr.ghu(oo_.dr.inv_order_var(p_r_bn), :) ]; 
 
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
H = 40;
Sirf = zeros(35, H);
Xirf = zeros(31, H);
shock_1 = [0; sigma; 0; sigma; 0; 0; 0; 0; 0; 0; sigma; sigma; sigma];
shock_label = {'TFP', 'C', 'H', 'mon', 'LTVI', 'Cap', 'LTVE', 'RW_E', 'RW_I', 'RW_n', 'Prov_E', 'Prov_I', 'Prov_n'};

%% Find the indices of non-zero elements in shock_1
non_zero_indices = find(shock_1 ~= 0);

%% Sort indices in descending order for backward removal
non_zero_indices = sort(non_zero_indices, 'descend');

% Compute and store the initial Xirf and Sirf with the full shock_1
Sirf(:, 1) = B * shock_1;
Xirf(:, 1) = D * shock_1;

for j = 2:H
    Sirf(:, j) = A * Sirf(:, j-1);
    Xirf(:, j) = C * Sirf(:, j-1);
end

modified_shock = shock_1;
% Loop through the non-zero indices in reverse order (backward removal)
for idx = 1:length(non_zero_indices) - 1
    % Copy original shock_1 and modify by setting the current index to 0
    modified_shock = modified_shock; 
    modified_shock(non_zero_indices(idx)) = 0;
    label = shock_label{non_zero_indices(idx)};
    % Display the label and modified shock vector
    fprintf('Modified shock after removing %s:\n', label);
    disp(modified_shock);
   
    % Compute new Sirf and Xirf for the modified shock
    new_Sirf = zeros(35, H); % Temporary matrix to store new Sirf
    new_Xirf = zeros(31, H); % Temporary matrix to store new Xirf
    new_Sirf(:, 1) = B * modified_shock;
    new_Xirf(:, 1) = D * modified_shock;
    
    for j = 2:H
        new_Sirf(:, j) = A * new_Sirf(:, j-1);
        new_Xirf(:, j) = C * new_Sirf(:, j-1);
    end
    
    % Generate dynamic variable names based on the shock removed
    label = shock_label{non_zero_indices(idx)};
    Sirf_name = ['Sirf_' label];
    Xirf_name = ['Xirf_' label];
    
    % Assign the new Sirf and Xirf to dynamically generated names in base workspace
    assignin('base', Sirf_name, new_Sirf);
    assignin('base', Xirf_name, new_Xirf);
end

% Display the completion message
disp('Computation complete for all shock adjustments in reverse order.');


 