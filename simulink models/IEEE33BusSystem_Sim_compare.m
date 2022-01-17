% IEEE 33 with DGs. Simulink
% Simulation compare.

clc
clear all
%%
dy_n = 0.03; % Delta y normalization [p.u.] 
du_n = 500;  % Delta u normalization [p.u.]
dk_n = dy_n/du_n;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References of Control structures:
%   (d1): Gvn_d1 = [Gn(1,1) 0 0 0 0 0;
%                   0 Gn(2,2) 0 0 0 0;
%                   0 0 Gn(3,3) 0 0 0;
%                   0 0 0 Gn(4,4) 0 0;
%                   0 0 0 0 Gn(5,5) 0;
%                   0 0 0 0 0 Gn(6,6)];
%   (s): Gvn_s = [Gn(1,1) Gn(1,2) 0 0 0 0;
%                Gn(2,1) Gn(2,2) 0 0 0 0;
%                0 0 Gn(3,3) 0 0 0;
%                0 0 0 Gn(4,4) 0 0;
%                0 0 0 0 Gn(5,5) Gn(5,6);
%                0 0 0 0 Gn(6,5) Gn(6,6)];
%   (f): Full.
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
load Kimc_d1_sce1-0
VSimMat_d_d1 = VSimMat_d;
Pdg_d_d1 = Pdg_d/1e3;
Qdg_d_d1 = Qdg_d/1e3;
tout_d_d1 = tout_d;
SP_d_d1 = SP_d;


load Kimc_s_sce1-0
VSimMat_d_s = VSimMat_d;
Pdg_d_s = Pdg_d/1e3;
Qdg_d_s = Qdg_d/1e3;
tout_d_s = tout_d;
SP_d_s = SP_d;

load Kimc_f_sce1-0
VSimMat_d_f = VSimMat_d;
Pdg_d_f = Pdg_d/1e3;
Qdg_d_f = Qdg_d/1e3;
tout_d_f = tout_d;
SP_d_f = SP_d;

%%
Ts = tout_d(2)-tout_d(1);   
n_step = 0/Ts+1;
tt = tout_d(n_step:end)-tout_d(n_step);

% Buses Voltages
v14_d = VSimMat_d_d1(n_step:end,14);
v14_s = VSimMat_d_s(n_step:end,14);
v14_f = VSimMat_d_f(n_step:end,14);

v9_d = VSimMat_d_d1(n_step:end,9);
v9_s = VSimMat_d_s(n_step:end,9);
v9_f = VSimMat_d_f(n_step:end,9);

v18_d = VSimMat_d_d1(n_step:end,18);
v18_s = VSimMat_d_s(n_step:end,18);
v18_f = VSimMat_d_f(n_step:end,18);
v21_d = VSimMat_d_d1(n_step:end,21);
v21_s = VSimMat_d_s(n_step:end,21);
v21_f = VSimMat_d_f(n_step:end,21);
v25_d = VSimMat_d_d1(n_step:end,25);
v25_s = VSimMat_d_s(n_step:end,25);
v25_f = VSimMat_d_f(n_step:end,25);
v30_d = VSimMat_d_d1(n_step:end,30);
v30_s = VSimMat_d_s(n_step:end,30);
v30_f = VSimMat_d_f(n_step:end,30);
v33_d = VSimMat_d_d1(n_step:end,33);
v33_s = VSimMat_d_s(n_step:end,33);
v33_f = VSimMat_d_f(n_step:end,33);

%Manipulated variables
Qdg_1_d = Qdg_d_d1(n_step:end,1);
Qdg_1_s = Qdg_d_s(n_step:end,1);
Qdg_1_f = Qdg_d_f(n_step:end,1);

Qdg_2_d = Qdg_d_d1(n_step:end,2);
Qdg_2_s = Qdg_d_s(n_step:end,2);
Qdg_2_f = Qdg_d_f(n_step:end,2);

Qdg_3_d = Qdg_d_d1(n_step:end,3);
Qdg_3_s = Qdg_d_s(n_step:end,3);
Qdg_3_f = Qdg_d_f(n_step:end,3);

Qdg_4_d = Qdg_d_d1(n_step:end,4);
Qdg_4_s = Qdg_d_s(n_step:end,4);
Qdg_4_f = Qdg_d_f(n_step:end,4);

Qdg_5_d = Qdg_d_d1(n_step:end,5);
Qdg_5_s = Qdg_d_s(n_step:end,5);
Qdg_5_f = Qdg_d_f(n_step:end,5);

Qdg_6_d = Qdg_d_d1(n_step:end,6);
Qdg_6_s = Qdg_d_s(n_step:end,6);
Qdg_6_f = Qdg_d_f(n_step:end,6);


%%
% figure
% set(gcf, 'Position', [0 0 800 1050]);
% subplot(2,3,1),plot(tt,v14_d,tt,v14_s,tt,v14_f),grid on,xlabel('time (s)'),ylabel('v_{14} (pu)')
% legend('\Gamma_{d}','\Gamma_{s}','\Gamma_{f}')
% subplot(2,3,2),plot(tt,v18_d,tt,v18_s,tt,v18_f),grid on, xlabel('time (s)'),ylabel('v_{18} (pu)')
% subplot(2,3,3),plot(tt,v21_d,tt,v21_s,tt,v21_f),grid on, xlabel('time (s)'),ylabel('v_{21} (pu)')
% subplot(2,3,4),plot(tt,v25_d,tt,v25_s,tt,v25_f),grid on, xlabel('time (s)'),ylabel('v_{25} (pu)')
% subplot(2,3,5),plot(tt,v30_d,tt,v30_s,tt,v30_f),grid on, xlabel('time (s)'),ylabel('v_{30} (pu)')
% subplot(2,3,6),plot(tt,v33_d,tt,v33_s,tt,v33_f),grid on, xlabel('time (s)'),ylabel('v_{33} (pu)')
% 
% figure                                                                                             
% set(gcf, 'Position', [900 0 800 1050]);                                                            
% subplot(2,3,1),plot(tt,Qdg_1_d,tt,Qdg_1_s,tt,Qdg_1_f),grid on, xlabel('time (s)'),ylabel('Qdg_1 (kVAr)')     
% legend('\Gamma_{d}','\Gamma_{s}','\Gamma_{f}')                                                   
% subplot(2,3,2),plot(tt,Qdg_2_d,tt,Qdg_2_s,tt,Qdg_2_f),grid on, xlabel('time (s)'),ylabel('Qdg_2 (kVAr)')     
% subplot(2,3,3),plot(tt,Qdg_3_d,tt,Qdg_3_s,tt,Qdg_3_f),grid on, xlabel('time (s)'),ylabel('Qdg_3 (kVAr)')     
% subplot(2,3,4),plot(tt,Qdg_4_d,tt,Qdg_4_s,tt,Qdg_4_f),grid on, xlabel('time (s)'),ylabel('Qdg_4 (kVAr)')     
% subplot(2,3,5),plot(tt,Qdg_5_d,tt,Qdg_5_s,tt,Qdg_5_f),grid on, xlabel('time (s)'),ylabel('Qdg_5 (kVAr)')     
% subplot(2,3,6),plot(tt,Qdg_6_d,tt,Qdg_6_s,tt,Qdg_6_f),grid on, xlabel('time (s)'),ylabel('Qdg_6 (kVAr)')
%%nq6 nq5 nq3
figure
set(gcf, 'Position', [0 0 800 1050]);
subplot(2,3,1),plot(tt,v14_d,tt,v14_s,tt,v14_f),grid on,xlabel('time (s)'),ylabel('v_{14} (pu)'),xlim([5 15])
legend('\Gamma_{d6}','\Gamma_{d5}','\Gamma_{d3}')
subplot(2,3,2),plot(tt,v18_d,tt,v18_s,tt,v18_f),grid on, xlabel('time (s)'),ylabel('$v_{18}$ (pu)','Interpreter','latex'),xlim([5 15])
subplot(2,3,3),plot(tt,v21_d,tt,v21_s,tt,v21_f),grid on, xlabel('time (s)'),ylabel('v_{21} (pu)'),xlim([5 15])
subplot(2,3,4),plot(tt,v25_d,tt,v25_s,tt,v25_f),grid on, xlabel('time (s)'),ylabel('v_{25} (pu)'),xlim([5 15])
subplot(2,3,5),plot(tt,v30_d,tt,v30_s,tt,v30_f),grid on, xlabel('time (s)'),ylabel('v_{30} (pu)'),xlim([5 15])
subplot(2,3,6),plot(tt,v33_d,tt,v33_s,tt,v33_f),grid on, xlabel('time (s)'),ylabel('v_{33} (pu)'),xlim([5 15])


figure                                                                                             
set(gcf, 'Position', [900 0 800 1050]);                                                            
subplot(2,3,1),plot(tt,Qdg_1_d,tt,Qdg_1_s,tt,Qdg_1_f),grid on, xlabel('time (s)'),ylabel('Qdg_1 (kVAr)'),xlim([5 15])     
legend('\Gamma_{d6}','\Gamma_{d5}','\Gamma_{d3}')                                                   
subplot(2,3,2),plot(tt,Qdg_2_d,tt,Qdg_2_s,tt,Qdg_2_f),grid on, xlabel('time (s)'),ylabel('Qdg_2 (kVAr)'),xlim([5 15])     
subplot(2,3,3),plot(tt,Qdg_3_d,tt,Qdg_3_s,tt,Qdg_3_f),grid on, xlabel('time (s)'),ylabel('Qdg_3 (kVAr)'),xlim([5 15])     
subplot(2,3,4),plot(tt,Qdg_4_d,tt,Qdg_4_s,tt,Qdg_4_f),grid on, xlabel('time (s)'),ylabel('Qdg_4 (kVAr)'),xlim([5 15])     
subplot(2,3,5),plot(tt,Qdg_5_d,tt,Qdg_5_s,tt,Qdg_5_f),grid on, xlabel('time (s)'),ylabel('Qdg_5 (kVAr)'),xlim([5 15])     
subplot(2,3,6),plot(tt,Qdg_6_d,tt,Qdg_6_s,tt,Qdg_6_f),grid on, xlabel('time (s)'),ylabel('Qdg_6 (kVAr)'),xlim([5 15])
xlim([5 15])

% figure
% set(gcf, 'Position', [0 0 800 1050]);
% subplot(2,3,1),plot(tt,v14_d,tt,v14_s),grid on,xlabel('time (s)'),ylabel('v_{14} (pu)')
% legend('\Gamma_{d6}','\Gamma_{d5}')
% subplot(2,3,2),plot(tt,v18_d,tt,v18_s),grid on, xlabel('time (s)'),ylabel('v_{18} (pu)')
% subplot(2,3,3),plot(tt,v21_d,tt,v21_s),grid on, xlabel('time (s)'),ylabel('v_{21} (pu)')
% subplot(2,3,4),plot(tt,v25_d,tt,v25_s),grid on, xlabel('time (s)'),ylabel('v_{25} (pu)')
% subplot(2,3,5),plot(tt,v30_d,tt,v30_s),grid on, xlabel('time (s)'),ylabel('v_{30} (pu)')
% subplot(2,3,6),plot(tt,v33_d,tt,v33_s),grid on, xlabel('time (s)'),ylabel('v_{33} (pu)')
% 
% figure                                                                                             
% set(gcf, 'Position', [900 0 800 1050]);                                                            
% subplot(2,3,1),plot(tt,Qdg_1_d,tt,Qdg_1_s),grid on, xlabel('time (s)'),ylabel('Qdg_1 (kVAr)')     
% legend('\Gamma_{d6}','\Gamma_{d5}')                                                   
% subplot(2,3,2),plot(tt,Qdg_2_d,tt,Qdg_2_s),grid on, xlabel('time (s)'),ylabel('Qdg_2 (kVAr)')     
% subplot(2,3,3),plot(tt,Qdg_3_d,tt,Qdg_3_s),grid on, xlabel('time (s)'),ylabel('Qdg_3 (kVAr)')     
% subplot(2,3,4),plot(tt,Qdg_4_d,tt,Qdg_4_s),grid on, xlabel('time (s)'),ylabel('Qdg_4 (kVAr)')     
% subplot(2,3,5),plot(tt,Qdg_5_d,tt,Qdg_5_s),grid on, xlabel('time (s)'),ylabel('Qdg_5 (kVAr)')     
% subplot(2,3,6),plot(tt,Qdg_6_d,tt,Qdg_6_s),grid on, xlabel('time (s)'),ylabel('Qdg_6 (kVAr)')


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAE Calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% iae1_d = sum(abs(SP_d_d1(n_step:end,1)-v14_d));
% iae1_s = sum(abs(SP_d_s(n_step:end,1)-v14_s));
% iae1_f = sum(abs(SP_d_f(n_step:end,1)-v14_f));
% 
% iae2_d = sum(abs(SP_d_d1(n_step:end,2)-v18_d));
% iae2_s = sum(abs(SP_d_s(n_step:end,2)-v18_s));
% iae2_f = sum(abs(SP_d_f(n_step:end,2)-v18_f));
% 
% iae3_d = sum(abs(SP_d_d1(n_step:end,3)-v21_d));
% iae3_s = sum(abs(SP_d_s(n_step:end,3)-v21_s));
% iae3_f = sum(abs(SP_d_f(n_step:end,3)-v21_f));
% 
% iae4_d = sum(abs(SP_d_d1(n_step:end,4)-v25_d));
% iae4_s = sum(abs(SP_d_s(n_step:end,4)-v25_s));
% iae4_f = sum(abs(SP_d_f(n_step:end,4)-v25_f));
% 
% iae5_d = sum(abs(SP_d_d1(n_step:end,5)-v30_d));
% iae5_s = sum(abs(SP_d_s(n_step:end,5)-v30_s));
% iae5_f = sum(abs(SP_d_f(n_step:end,5)-v30_f));
% 
% iae6_d = sum(abs(SP_d_d1(n_step:end,6)-v33_d));
% iae6_s = sum(abs(SP_d_s(n_step:end,6)-v33_s));
% iae6_f = sum(abs(SP_d_f(n_step:end,6)-v33_f));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Control Energy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ll = length(Qdg_1_d);
mv_max = 500;
% mv1
Eu_mv1_d= sum(((Qdg_1_d-Qdg_1_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv1_s = sum(((Qdg_1_s-Qdg_1_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv1_f = sum(((Qdg_1_f-Qdg_1_f(1)*ones(ll,1))./mv_max).^2);
%mv2
Eu_mv2_d= sum(((Qdg_2_d-Qdg_2_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv2_s = sum(((Qdg_2_s-Qdg_2_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv2_f = sum(((Qdg_2_f-Qdg_2_f(1)*ones(ll,1))./mv_max).^2);
%mv3
Eu_mv3_d= sum(((Qdg_3_d-Qdg_3_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv3_s = sum(((Qdg_3_s-Qdg_3_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv3_f = sum(((Qdg_3_f-Qdg_3_f(1)*ones(ll,1))./mv_max).^2);
%mv4
Eu_mv4_d= sum(((Qdg_4_d-Qdg_4_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv4_s = sum(((Qdg_4_s-Qdg_4_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv4_f = sum(((Qdg_4_f-Qdg_4_f(1)*ones(ll,1))./mv_max).^2);
%mv5
Eu_mv5_d= sum(((Qdg_5_d-Qdg_5_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv5_s = sum(((Qdg_5_s-Qdg_5_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv5_f = sum(((Qdg_5_f-Qdg_5_f(1)*ones(ll,1))./mv_max).^2);
%mv6
Eu_mv6_d= sum(((Qdg_6_d-Qdg_6_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv6_s = sum(((Qdg_6_s-Qdg_6_s(1)*ones(ll,1))./mv_max).^2);
Eu_mv6_f = sum(((Qdg_6_f-Qdg_6_f(1)*ones(ll,1))./mv_max).^2);

%%
% disp('IAE')
% disp([num2str(iae1_d),' & ',num2str(iae2_d),' & ',num2str(iae3_d),' & ',num2str(iae4_d),' & ',num2str(iae5_d),' & ',num2str(iae6_d),'\\'])
% disp([num2str(iae1_s),' & ',num2str(iae2_s),' & ',num2str(iae3_s),' & ',num2str(iae4_s),' & ',num2str(iae5_s),' & ',num2str(iae6_s),'\\'])
% disp([num2str(iae1_f),' & ',num2str(iae2_f),' & ',num2str(iae3_f),' & ',num2str(iae4_f),' & ',num2str(iae5_f),' & ',num2str(iae6_f),'\\'])

disp('Eu')
disp([num2str(Eu_mv1_d),' & ',num2str(Eu_mv2_d),' & ',num2str(Eu_mv3_d),' & ',num2str(Eu_mv4_d),' & ',num2str(Eu_mv5_d),' & ',num2str(Eu_mv6_d),'\\'])
disp([num2str(Eu_mv1_s),' & ',num2str(Eu_mv2_s),' & ',num2str(Eu_mv3_s),' & ',num2str(Eu_mv4_s),' & ',num2str(Eu_mv5_s),' & ',num2str(Eu_mv6_s),'\\'])
disp([num2str(Eu_mv1_f),' & ',num2str(Eu_mv2_f),' & ',num2str(Eu_mv3_f),' & ',num2str(Eu_mv4_f),' & ',num2str(Eu_mv5_f),' & ',num2str(Eu_mv6_f),'\\'])
% 
% disp('IAE')
% disp([num2str(iae1_d),' & ',num2str(iae2_d),' & ',num2str(iae3_d),' & ',num2str(iae4_d),' & ',num2str(iae5_d),' & ',num2str(iae6_d),'\\'])
% disp([num2str(iae1_s),' & ',num2str(iae2_s),' & ',num2str(iae3_s),' & ',num2str(iae4_s),' & ',num2str(iae5_s),' & ',num2str(iae6_s),'\\'])
% 
% disp('Eu')
% disp([num2str(Eu_mv1_d),' & ',num2str(Eu_mv2_d),' & ',num2str(Eu_mv3_d),' & ',num2str(Eu_mv4_d),' & ',num2str(Eu_mv5_d),' & ',num2str(Eu_mv6_d),'\\'])
% disp([num2str(Eu_mv1_s),' & ',num2str(Eu_mv2_s),' & ',num2str(Eu_mv3_s),' & ',num2str(Eu_mv4_s),' & ',num2str(Eu_mv5_s),' & ',num2str(Eu_mv6_s),'\\'])


