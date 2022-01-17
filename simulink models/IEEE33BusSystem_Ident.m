% IEEE 33 with DGs. Simulink
% Modelo identification: First order plus delay (FOPD).
clc
clear all

% Model initialization script
run IEEE33BusSystem
% Esta normalización seria prolijo que sea igual a la usada para el diseño
% del control, pero no necesariamente tiene que ser la misma. Es sólo para
% implementación en el modelo dinámico.

dy_n = 0.03; % Delta y normalization [p.u.] 
du_n = 500;  % Delta u normalization [p.u.]
dk_n = dy_n/du_n;

%%
%Initial OP
P_dg0 = 300*ones(1,6);
Q_dg0 = zeros(1,6);

% [P_dg1_f,P_dg2_f,P_dg3_f,P_dg4_f,P_dg5_f,P_dg6_f] = deal(300);
% [Q_dg1_f,Q_dg2_f,Q_dg3_f,Q_dg4_f,Q_dg5_f,Q_dg6_f] = deal(0);

% v0 = [ 1.0000, 0.9979, 0.9881, 0.9832, 0.9785, 0.9659, 0.9629, 0.9606,...
%        0.9580, 0.9563, 0.9560, 0.9559, 0.9559, 0.9549, 0.9548, 0.9549,...
%        0.9552, 0.9560, 0.9977, 0.9971, 0.9966, 0.9963, 0.9853, 0.9804,...
%        0.9787, 0.9646, 0.9632, 0.9554, 0.9501, 0.9486, 0.9462, 0.9459,...
%        0.9462];
v0 = ones(1,33);    
v0_sim = [1.000000	0.998190	0.989885	0.985897	0.982170	0.971959...
       0.969608	0.967980	0.966200	0.964927	0.965075	0.965125...
       0.965180	0.965184	0.965122	0.965581	0.966583	0.967423...
       0.998041	0.997391	0.997803	0.996763	0.987336	0.982772...
       0.981251	0.971028	0.969765	0.963869	0.959695	0.958457...
       0.956764	0.956699	0.957211];
   
% voltages at initial OP of selected CVs
CVs_sel = [6  17  19  23  28  33];

V_0 = v0_sim(CVs_sel);

% V_0 = [v0(14), v0(18), v0(21), v0(25), v0(30), v0(33)];

%%
run mv_ident_d
% run mv1_ident
% run mv2_ident
% run mv3_ident
% run mv4_ident
% run mv5_ident
% run mv6_ident
%%
% Process
% Gn = [g11 g12 g13 g14 g15 g16;
%       g21 g22 g23 g24 g25 g26;
%       g31 g32 g33 g34 g35 g36;
%       g41 g42 g43 g44 g45 g46;
%       g51 g52 g43 g54 g55 g56;
%       g61 g62 g43 g64 g65 g66]; 
