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
%Initial OP
P_dg0 = 300*ones(1,6);
Q_dg0 = zeros(1,6);
Q_dg0(5) = -20.94;
%voltages at initial OP
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
%%
% Model identification data
% Selected CVs = [14, 18, 21, 25, 30, 33]
load ident_control_Kidl

% voltages at initial OP of selected CVs   
V_0_sp = [v0_sim(14), v0_sim(18), v0_sim(21), v0_sim(25), v0_sim(33)];
V_0 = [v0_sim(14), v0_sim(18), v0_sim(21), v0_sim(25), v0_sim(30), v0_sim(33)];
%% Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtro

% Valores nominales =
Tf = Tp*5;
fd1 = tf([0 1],[Tf 1]);
fd2 = tf([0 1],[Tf 1]); 
fd3 = tf([0 1],[Tf 1]);   
fd4 = tf([0 1],[Tf 1]); 
fd6 = tf([0 1],[Tf 1]); 

F_d = [fd1 0 0 0  0;
       0 fd2 0 0  0;
       0 0 fd3 0  0;
       0 0 0 fd4  0;
       0 0 0 0  fd6];


%%
% Decentralized IMC controller No 1  
% Gvn_d1 = [Gn(1,1) 0 0 0 0 0;
%         0 Gn(2,2) 0 0 0 0;
%         0 0 Gn(3,3) 0 0 0;
%         0 0 0 Gn(4,4) 0 0;
%         0 0 0 0 Gn(5,5) 0;
%         0 0 0 0 0 Gn(6,6)];
    
Gvn_d_nq_5 = [Gn(1,1) 0 0 0  0;
              0 Gn(2,2) 0 0  0;
              0 0 Gn(3,3) 0  0;
              0 0 0 Gn(4,4)  0;
              0 0 0 0  Gn(6,6)];

Kimc_d_nq5 = (Gvn_d_nq_5^-1)*F_d;    
% Ki_ss = dcgain(Kimc_d1) 

%%
% Full IMC controller No 1  
% Gvn_f = Gn;
%     
% Kimc_f = (Gvn_f^-1)*F_d; 
%%
% Sparse IMC Controller No 1
% Gvn_s = [Gn(1,1) Gn(1,2) 0 0 0 0;
%          Gn(2,1) Gn(2,2) 0 0 0 0;
%           0 0 Gn(3,3) 0 0 0;
%           0 0 0 Gn(4,4) 0 0;
%           0 0 0 0 Gn(5,5) Gn(5,6);
%           0 0 0 0 Gn(6,5) Gn(6,6)];
      
% Gvn_s = [Gn(1,1) Gn(1,2) 0 0 0 0;
%          Gn(2,1) Gn(2,2) 0 0 0 0;
%           0 0        Gn(3,3) 0 0 0;
%           0 0        Gn(4,3) Gn(4,4) 0 0;
%           0 0         0 0 Gn(5,5) Gn(5,6);
%           0 0         0 0 Gn(6,5) Gn(6,6)];      
% 
% Kimc_s= (Gvn_s^-1)*F_d; 
%% Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scenarios:
% sce1- Regulator. Disturbance rejection. Active power step:
%       0- All Pdg_i = 300 kW --> 100 kW . (Kimc_(...)_esc1-0)
%       i- Pdg_i = 300 kW --> 100 kW, Pdg_(not i) = 300 kW(Kimc_(...)_esc1-i)
% sce2- Servo. SP tracking :
%       0- Vsp for OP Loss minimization in Matpower
%               Vsp =  [0.9879    0.9952    0.9987    0.9841    0.9732    0.9749];
%       10- Vsp for minimization voltage deviation from 1 pu
%               Vsp = [1.0039 1.0141 1.0019 0.9902 0.9858 0.9898]; 
%       1- SP change in v_14: Vsp(1) =0.9622; (no MVs saturation obtained in simulink)
%       2- SP change in v_18: Vsp(2) =0.9645; (no MVs saturation obtained in simulink)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%Disturbance
% No SP changes
Vsp = V_0;
tsp = 3*ones(1,6);
% 
%P_dgf(6)
P_dgf = 100*ones(1,6);
tPdg = 10*ones(1,6);

% P_dgf(4) = 100;

%SP change
% V SP for OP Loss minimization in Matpower
% Vsp =  [0.9879    0.9952    0.9987    0.9841    0.9732    0.9749];
% V SP for minimization voltage deviation from 1 pu
% Vsp = [1.0039 1.0141 1.0019 0.9902 0.9858 0.9898]; 

% Step at individual CVs
% Vsp = V_0;
% % Vsp(1) =0.9622;
% Vsp(2) = 0.9645;
% tsp = 10*ones(1,6);
% %NO P_dg changes
% P_dgf = 300*ones(1,6);
% tPdg = 10*ones(1,6);

%%
%Descentalized
% Gvn = Gvn_d1;
% Kimc = Kimc_d1;
% 
% sim('IEEE33BusTestSystem_DG_Control_IMC')
% save('Kimc_d1_sce2-2')

%Sparse
Gvn = Gvn_d_nq_5;
Kimc = Kimc_d_nq5;
    
sim('IEEE33BusTestSystem_DG_Control_IMC_nq5')
save('Kimc_d_nq5_sce1-0')

%Full
% Gvn = Gvn_f;
% Kimc = Kimc_f;
% 
% sim('IEEE33BusTestSystem_DG_Control_IMC')
% save('Kimc_f_sce2-2')
%%
