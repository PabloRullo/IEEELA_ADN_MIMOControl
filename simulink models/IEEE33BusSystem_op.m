% IEEE 33 with DGs. Simulink
% Modelo identification: First order plus delay (FOPD).
clc
clear all

% Model initialization script
run IEEE33BusSystem
Ts = 0.005;
% Esta normalización seria prolijo que sea igual a la usada para el diseño
% del control, pero no necesariamente tiene que ser la misma. Es sólo para
% implementación en el modelo dinámico.

dy_n = 0.03; % Delta y normalization [p.u.] 
du_n = 500;  % Delta u normalization [p.u.]
dk_n = dy_n/du_n;
%%
% Punto de operaci�n
P_dg0 = 300*ones(1,6);
Q_dg0 = zeros(1,6);

%voltages at initial OP (matpower)
% v0 = [ 1.0000, 0.9979, 0.9881, 0.9832, 0.9785, 0.9659, 0.9629, 0.9606,...
%        0.9580, 0.9563, 0.9560, 0.9559, 0.9559, 0.9549, 0.9548, 0.9549,...
%        0.9552, 0.9560, 0.9977, 0.9971, 0.9966, 0.9963, 0.9853, 0.9804,...
%        0.9787, 0.9646, 0.9632, 0.9554, 0.9501, 0.9486, 0.9462, 0.9459,...
%        0.9462];
   
   v0 = ones(1,33);
% voltages at initial OP of selected CVs   
V_0 = [v0(14), v0(18), v0(21), v0(25), v0(30), v0(33)];


P_dgf = 300*ones(1,6);
tPdg = 0.5*ones(1,6);

Q_dgf = zeros(1,6);
% Q_dgf(1) = 400;  %kVAr
tQdg = 0.5*ones(1,6);

%simulate
sim('IEEE33BusTestSystem_DG_Ident')

%%
v0_sim = VSimMat_d(end,:);