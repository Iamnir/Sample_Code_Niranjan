% Author: Niranjan Kumar
% Assuming big_gamma_P, big_gamma_I, big_gamma_E are defined elsewhere

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Consumption_P - SIRF ROw - 1
%Consumption_I - SIRF Row - 2 
%Consumption_E - SIRF  Row - 7
%Compute Total Consumption from above using the mass of each agent

%Inflation - SIRF Row - 25 
%Output    - SIRF Row - 26 Compute Total Output 

%Bank Capital - SIRF Row -14 
%NBFC Capital - SIRF Row - 22 
%Loan to Households from NBFC - SIRF Row - 33 
%Loan to Households from Bank - SIRF Row - 30

%Toal Bank Loan - XIRF Row - 25 
%Bank Loan to Entrepreneurs XIRF Row - 23 
%Bank Loan to NBFC XIRF Row - 29 


rows_X = [23, 25, 28, 29];  % Rows from Xirf to be plotted
rows_X_label = {'Loan to Entrepreneurs from Banks', 'Total Bank Loan', 'Total NBFC Loan', 'Loan to NBFC from Banks'};  % Labels for the corresponding rows
rows_S2 = [23, 25, 14, 22, 30, 33]; 
rows_S2_label = {'psi_n', 'Inflation', 'Bank Capital', 'NBFC Capital', 'Loan to Households from Bank', 'Loan to Households from NBFCs'}; 


 
output_folder = 'C:\Users\niranjan.kumar\Desktop\Macroprudential_Niranjan\Analysis\Graphs\Group_1';  % Change this to your desired folder

% Ensure the folder exists, or create it if it doesn't
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%Figure - 'Total Bank Loan'
figure; 
set(gcf, 'Position', [100, 100, 700, 500]);  

subplot(3, 3, 1);
hold on;
plot(Xirf_con(25, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Xirf_pn(25, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--', 'LineWidth', 2); % Teal with star marker
plot(Xirf_pE(25, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Xirf_pI(25, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Xirf_mon(25, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6)% Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Total Bank Loan', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
%legend('Consumption', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon', 'Location', 'best');
% Enable grid
min_y = min([Xirf_con(25, :), Xirf_pn(25, :), Xirf_pE(25, :), Xirf_pI(25, :), Xirf_mon(25, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;

%Figure - 'Loan to Entrepreneurs from Banks'
subplot(3, 3, 2);
hold on;
plot(Xirf_con(23, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Xirf_pn(23, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--', 'LineWidth', 2); % Teal with star marker
plot(Xirf_pE(23, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Xirf_pI(23, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':', 'LineWidth', 2); % Light Red with dashed line
plot(Xirf_mon(23, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Entrepreneur Loan from Banks', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
%legend('Consumption', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon', 'Location', 'best');
% Enable grid
min_y = min([Xirf_con(23, :), Xirf_pn(23, :), Xirf_pE(23, :), Xirf_pI(23, :), Xirf_mon(23, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;



%Figure - 'Loan to NBFC from Banks'
subplot(3, 3, 3);

hold on;
plot(Xirf_con(29, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Xirf_pn(29, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Xirf_pE(29, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Xirf_pI(29, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':', 'LineWidth', 2); % Light Red with dashed line
plot(Xirf_mon(29, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('NBFC Loan from Banks', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
%legend('Consumption', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon', 'Location', 'best');
min_y = min([Xirf_con(29, :), Xirf_pn(29, :), Xirf_pE(29, :), Xirf_pI(29, :), Xirf_mon(29, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;


%Plot - Loan to Households from Banks

subplot(3, 3, 4); 
hold on;
plot(Sirf_con(30, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(30, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(30, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(30, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(30, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Households Loan from Banks', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
%legend('Consumption', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon', 'Location', 'best');
% Enable grid
min_y = min([Sirf_con(30, :), Sirf_pn(30, :), Sirf_pE(30, :), Sirf_pI(30, :), Sirf_mon(30, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;


hold off;


 




%Figure - 'Total NBFC Loan'

subplot(3, 3, 5); 
hold on;
plot(Xirf_con(28, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Xirf_pn(28, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--', 'LineWidth', 2); 
plot(Xirf_pE(28, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Xirf_pI(28, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Xirf_mon(28, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Total NBFC Loan', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
%legend('Consumption', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon', 'Location', 'best');
min_y = min([Xirf_con(28, :), Xirf_pn(28, :), Xirf_pE(28, :), Xirf_pI(28, :), Xirf_mon(28, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;

%Plot - Bank Capital 

subplot(3, 3, 6); 
hold on;
plot(Sirf_con(14, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(14, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(14, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(14, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':', 'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(14, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Bank Capital', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(14, :), Sirf_pn(14, :), Sirf_pE(14, :), Sirf_pI(14, :), Sirf_mon(14, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;

%Plot - NBFC  Capital 
subplot(3, 3, 7);
hold on;
plot(Sirf_con(22, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(22, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(22, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(22, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(22, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('NBFC Capital', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(22, :), Sirf_pn(22, :), Sirf_pE(22, :), Sirf_pI(22, :), Sirf_mon(22, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;

%Plot - Loan to Households from NBFCs
subplot(3, 3, 8);
hold on;
plot(Sirf_con(33, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(33, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(33, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(33, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':', 'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(33, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Loan to Households from NBFCs', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(33, :), Sirf_pn(33, :), Sirf_pE(33, :), Sirf_pI(33, :), Sirf_mon(33, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;

hold off;

% Plot - Inflation 
subplot(3, 3, 9)

hold on;
plot(Sirf_con(25, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(25, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(25, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(25, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(25, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Inflation', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(25, :), Sirf_pn(25, :), Sirf_pE(25, :), Sirf_pI(25, :), Sirf_mon(25, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
lgd = [0.93, 0.63, 0.11, 0.16];  % Adjust as needed
% Add the legend for the entire figure without border
lgd = legend({'Con', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon'}, 'Position', lgd);
set(lgd, 'Box', 'off');  % Turn off the legend box
hold off;

% Create a filename for saving
figure_name = 'Group_1_figure_1'; 
full_save_path = fullfile(output_folder, [figure_name, '.pdf']);  
saveas(gcf, full_save_path); 


figure; 
set(gcf, 'Position', [100, 100, 700, 500]);  

total_consumption_con = Sirf_con(1, :)*big_gamma_P + Sirf_con(2, :)*big_gamma_I + Sirf_con(7, :)*big_gamma_E;
total_consumption_pn = Sirf_pn(1, :)*big_gamma_P + Sirf_pn(2, :)*big_gamma_I + Sirf_pn(7, :)*big_gamma_E;
total_consumption_pE = Sirf_pE(1, :)*big_gamma_P + Sirf_pE(2, :)*big_gamma_I + Sirf_pE(7, :)*big_gamma_E;
total_consumption_pI = Sirf_pI(1, :)*big_gamma_P + Sirf_pI(2, :)*big_gamma_I + Sirf_pI(7, :)*big_gamma_E;
total_consumption_mon = Sirf_mon(1, :)*big_gamma_P + Sirf_mon(2, :)*big_gamma_I + Sirf_mon(7, :)*big_gamma_E;


total_output_con = Sirf_con(26, :)*big_gamma_E;
total_output_pn = Sirf_pn(26, :)*big_gamma_E; 
total_output_pE = Sirf_pE(26, :)*big_gamma_E;
total_output_pI = Sirf_pI(26, :)*big_gamma_E;
total_output_mon = Sirf_mon(26, :)*big_gamma_E;

%Plot - Total Output
subplot(3, 3, 1);
hold on;
plot(total_output_con, 'Color', [0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(total_output_pn, 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(total_output_pE, 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(total_output_pI, 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(total_output_mon, 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Total Output', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([total_output_con, total_output_pn, total_output_pE, total_output_pI, total_output_mon]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;




%Plot - Total Consumption 
subplot(3, 3, 2);
hold on;
plot(total_consumption_con, 'Color',[0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(total_consumption_pn, 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(total_consumption_pE, 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(total_consumption_pI, 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(total_consumption_mon, 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue

% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Total Consumption', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([total_consumption_con, total_consumption_pn, total_consumption_pE, total_consumption_pI, total_consumption_mon]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;

%Deposit Rate
subplot(3, 3, 3);
hold on;
plot(Sirf_con(6, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(6, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(6, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(6, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(6, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Deposit Rate', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(6, :), Sirf_pn(6, :), Sirf_pE(6, :), Sirf_pI(6, :), Sirf_mon(6, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
lgd = [0.93, 0.63, 0.11, 0.16];  % Adjust as needed
% Add the legend for the entire figure without border
lgd = legend({'Con', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon'}, 'Position', lgd);
set(lgd, 'Box', 'off');  % Turn off the legend box
hold off;
% 

 
%Interest Rate- Bank to Impatient Households
subplot(3, 3, 4); 

hold on;
plot(Sirf_con(31, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(31, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(31, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(31, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(31, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Bank Rate to Households', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(31, :), Sirf_pn(31, :), Sirf_pE(31, :), Sirf_pI(31, :), Sirf_mon(31, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;


%Interest Rate- Bank to Entrepreneurs
subplot(3, 3, 5); 
hold on;
plot(Sirf_con(32, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(32, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(32, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(32, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(32, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Bank Rate to Entrepreneurs', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(32, :), Sirf_pn(32, :), Sirf_pE(32, :), Sirf_pI(32, :), Sirf_mon(32, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;


%Interest Rate- Bank to NBFCs
subplot(3, 3, 6); 
hold on;
plot(Sirf_con(35, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(35, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(35, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(35, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(35, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Bank Rate to NBFCs', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(35, :), Sirf_pn(35, :), Sirf_pE(35, :), Sirf_pI(35, :), Sirf_mon(35, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;


%Interest Rate- NBFCs to Households 
subplot(3, 3, 7); 
hold on;
plot(Sirf_con(34, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(34, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(34, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(34, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(34, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('NBFCs Rate to Households', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
min_y = min([Sirf_con(34, :), Sirf_pn(34, :), Sirf_pE(34, :), Sirf_pI(34, :), Sirf_mon(34, :)]);
ylim([min_y, max(ylim)]); % Adjust y-limits starting from min_y
grid on;
hold off;


%Deposits
subplot(3, 3, 8); 
hold on;
plot(Sirf_con(5, :), 'Color', [0.4, 0, 0.6], 'LineStyle', '-',  'LineWidth', 2);  % Darker Blue with circle marker
plot(Sirf_pn(5, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); % Teal with star marker
plot(Sirf_pE(5, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); % Very light teal (mix of green and blue) with diamond marker
plot(Sirf_pI(5, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); % Light Red with dashed line
plot(Sirf_mon(5, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); % Brighter Sky Blue
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF', 'FontSize', 6); % Bold ylabel
title('Deposits', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
% Enable grid
grid on;
hold off;



%Deposits
subplot(3, 3, 9); 
hold on;
plot(Sirf_con(8, :), 'Color',[0.4, 0, 0.6], 'LineStyle', '-', 'LineWidth', 2);  
plot(Sirf_pn(8, :), 'Color', [1, 0.30, 0.5], 'LineStyle', '--',  'LineWidth', 2); 
plot(Sirf_pE(8, :), 'Color', [0.1, 0.75, 0.75], 'LineStyle', '-.', 'LineWidth', 2); 
plot(Sirf_pI(8, :), 'Color', [0.65, 0.16, 0.16], 'LineStyle', ':',  'LineWidth', 2); 
plot(Sirf_mon(8, :), 'Color', [0, 0.6, 1], 'LineStyle', '-', 'LineWidth', 2); 
% Add labels and legend
xlabel('Quarters after shock', 'FontSize', 6); % Bold xlabel
ylabel('IRF','FontSize', 6); % Bold ylabel
title('Capital', 'FontSize', 8, 'Color', [0, 0.5, 0.7]); % Title color in teal shade
% Enable grid
grid on;
lgd = [0.93, 0.63, 0.11, 0.16];  % Adjust as needed
% Add the legend for the entire figure without border
lgd = legend({'Con', '+ Prov_n', '+ Prov_E', '+ Prov_I', '+ mon'}, 'Position', lgd);
set(lgd, 'Box', 'off');  % Turn off the legend box
hold off;

% Create a filename for saving
figure_name = 'Group_1_figure_2'; 
full_save_path = fullfile(output_folder, [figure_name, '.pdf']);  
saveas(gcf, full_save_path);  
