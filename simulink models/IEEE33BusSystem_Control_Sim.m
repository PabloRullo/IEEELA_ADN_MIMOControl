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
%voltages at initial OP
% v0 = [ 1.0000, 0.9979, 0.9881, 0.9832, 0.9785, 0.9659, 0.9629, 0.9606,...
%        0.9580, 0.9563, 0.9560, 0.9559, 0.9559, 0.9549, 0.9548, 0.9549,...
%        0.9552, 0.9560, 0.9977, 0.9971, 0.9966, 0.9963, 0.9853, 0.9804,...
%        0.9787, 0.9646, 0.9632, 0.9554, 0.9501, 0.9486, 0.9462, 0.9459,...
%        0.9462]; % Matpower
   
% v0 = [1.00000	0.99802	0.98880	0.98427	0.97996	0.96833	0.96571	0.96377...
%       0.96149	0.96014	0.95980	0.95998	0.95991	0.95943	0.95956	0.95959...
%       0.96007	0.96101	0.99784	0.99725	0.99762	0.99691	0.98619	0.98105...
%       0.97951	0.96726	0.96590	0.95878	0.95406	0.95269	0.95034	0.94995...
%       0.95028]; %Simulink
 v0 = ones(1,33);
 
%  v0_sim = [1.000000	0.998193	0.989958	0.985995	0.982214	0.972087...
%           0.969527	0.968200	0.966263	0.965147	0.965198	0.965366...
%           0.965346	0.965384	0.965472	0.965839	0.966610	0.967516...
%           0.998024	0.997418	0.997687	0.996869	0.987410	0.982692...
%           0.981379	0.971120	0.970060	0.964136	0.960018	0.958657...
%           0.956952	0.956765	0.957137];
      
 v0_sim = [1.000000	0.998190	0.989885	0.985897	0.982170	0.971959...
          0.969608	0.967980	0.966200	0.964927	0.965075	0.965125...
          0.965180	0.965184	0.965122	0.965581	0.966583	0.967423...
          0.998041	0.997391	0.997803	0.996763	0.987336	0.982772...
          0.981251	0.971028	0.969765	0.963869	0.959695	0.958457...
          0.956764	0.956699	0.957211];

%%
% Model identification data
% Selected CVs = [14, 18, 21, 25, 30, 33]
% load ident_control_Kidl
% Selected CVs = [6  17  19  23  28  33]
load ident_control_Kid2

CVs_sel = [6  17  19  23  28  33];
% voltages at initial OP of selected CVs 
V_0 = v0_sim(CVs_sel);

  
%% Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtro

% Valores nominales =
Tf = Tp*5;
fd1 = tf([0 1],[Tf 1]);
fd2 = tf([0 1],[Tf 1]); 
fd3 = tf([0 1],[Tf 1]);   
fd4 = tf([0 1],[Tf 1]); 
fd5 = tf([0 1],[Tf 1]); 
fd6 = tf([0 1],[Tf 1]); 

F_d = [fd1 0 0 0 0 0;
       0 fd2 0 0 0 0;
       0 0 fd3 0 0 0;
       0 0 0 fd4 0 0;
       0 0 0 0 fd5 0;
       0 0 0 0 0 fd6];


%%
% Decentralized IMC controller No 1  
Gvn_d1 = [Gn(1,1) 0 0 0 0 0;
        0 Gn(2,2) 0 0 0 0;
        0 0 Gn(3,3) 0 0 0;
        0 0 0 Gn(4,4) 0 0;
        0 0 0 0 Gn(5,5) 0;
        0 0 0 0 0 Gn(6,6)];
 
Kimc_d1 = (Gvn_d1^-1)*F_d;    
% Ki_ss = dcgain(Kimc_d1) 

%%
% Full IMC controller No 1  
Gvn_f = Gn;
    
Kimc_f = (Gvn_f^-1)*F_d; 
%%
% Sparse IMC Controller No 1
Gvn_s = [Gn(1,1) Gn(1,2) 0 0 0 0;
         Gn(2,1) Gn(2,2) 0 0 0 0;
          0 0 Gn(3,3) 0 0 0;
          0 0 0 Gn(4,4) 0 0;
          0 0 0 0 Gn(5,5) Gn(5,6);
          0 0 0 0 Gn(6,5) Gn(6,6)];
      
% Gvn_s = [Gn(1,1) Gn(1,2) 0 0 0 0;
%          Gn(2,1) Gn(2,2) 0 0 0 0;
%           0 0        Gn(3,3) 0 0 0;
%           0 0        Gn(4,3) Gn(4,4) 0 0;
%           0 0         0 0 Gn(5,5) Gn(5,6);
%           0 0         0 0 Gn(6,5) Gn(6,6)];      

Kimc_s= (Gvn_s^-1)*F_d; 
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
Gvn = Gvn_d1;
Kimc = Kimc_d1;

sim('IEEE33BusTestSystem_DG_Control_IMC')
save('Kimc_d_d1_sce1-0')

%Sparse
% Gvn = Gvn_s;
% Kimc = Kimc_s;
% 
% sim('IEEE33BusTestSystem_DG_Control_IMC')
% save('Kimc_ops_s_sce1-0')

%Full
% Gvn = Gvn_f;
% Kimc = Kimc_f;
% 
% sim('IEEE33BusTestSystem_DG_Control_IMC')
% save('Kimc_ops_f_sce1-0')
%%
