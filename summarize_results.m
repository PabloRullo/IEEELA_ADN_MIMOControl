% Resumen diseños.
clc
clear all
close all
%%
%%%%%%%%%%%%%%%%%%%%%
% 1- Full loads
%%%%%%%%%%%%%%%%%%%%%
% a. Y_NF = 0.03
% run NLE_GA.m :
% with
% Gcsv = readtable('Datos_G_IEEE33_0-03.csv');
% Dcsv = readtable('Datos_De_IEEE33_0-03.csv');
% qa = 0


load SS_Y_NF_0-03_FL_opt.mat
load SS_data_YNF_0-03_FL.mat

fprintf('Number of additional components: %d\n', qa_opt);
disp('Note: If D is formed only with DGs active power as disturbance, the optimum structure results a full ');
structure
fprintf('NLE:   %.3f \n', NLE_opt);
fprintf('NLE_d: %.3f \n', NLE_d_opt);
fprintf('NLE_sp:%.3f \n', NLE_sp_opt);

id_qa = [1:length(NLE)];

figure
plot(id_qa,NLE_sp,'r--*'), hold on, grid on
plot(id_qa,NLE_d,'b--o'), hold on, grid on
plot(id_qa,NLE,'k-s'), hold on, grid on
title('Y_NF = 0.03')
xlabel('Additional model components')
ylabel('NLE value')
stem(qa_opt+1, NLE_opt,'MarkerSize',10, 'LineWidth', 2)
legend('NLE_{sp}', 'NLE_d', 'NLE', 'opt')
%%
clear all
clc

% b. Y_NF = 0.01
% run NLE_GA.m :
% with
% Gcsv = readtable('Datos_G_IEEE33_0-01.csv');
% Dcsv = readtable('Datos_De_IEEE33_0-01.csv');
% qa = 0

load SS_Y_NF_0-01_FL_opt.mat
load SS_data_YNF_0-01_FL.mat

fprintf('Number of additional components: %d\n', qa_opt);
disp('Note: If D is formed only with DGs active power as disturbance, the optimum structure is the same ');
structure
fprintf('NLE: %.3f \n ', NLE_opt);
fprintf('NLE_d:  %.3f \n', NLE_d_opt);
fprintf('NLE_sp:  %.3f \n', NLE_sp_opt);

id_qa = [1:length(NLE)];        

figure
plot(id_qa,NLE_sp,'r--*'), hold on, grid on
plot(id_qa,NLE_d,'b--o'), hold on, grid on
plot(id_qa,NLE,'k-s'), hold on, grid on
title('Y_NF = 0.01')
xlabel('Additional model components')
ylabel('NLE value')
stem(qa_opt+1, NLE_opt,'MarkerSize',10, 'LineWidth', 2)
legend('NLE_{sp}', 'NLE_d', 'NLE', 'opt')

