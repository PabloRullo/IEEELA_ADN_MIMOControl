%%
% URUCON 2021 Plots
%%
clear all
clc
load NLE_profile_descbase_local_D_dy0-03
NLE_prof = [ 41.0291 NLE];
ind = [0:qfull];

figure
plot(ind,NLE_prof,'-o'),grid on
ax = gca;
ax.GridLineStyle = ':';
ax.FontSize = 13;
% ax.Markers = 'o';
% ax.LineStyle = '-';
% ax.LabelFontSizeMultiplier = 1.25;
ylabel('value','Interpreter','latex','FontSize',19)
xlabel('number of additional components ($q_a$)','Interpreter','latex','FontSize',19)

% plot(tout,wm_giw*50,'Color',[0.8 0.8 0.8],'LineStyle','-','LineWidth',2),grid on
% plot(tout,wm_cau*50,'Color',[0 0 0],'LineStyle','-'),grid on
% plot(tout,wm_caw*50,'Color',[0.2 0.2 0.2],'LineStyle','-.')
% plot(tout,wm_fix*50,'Color',[0.4 0.4 0.4],'LineStyle','--')
% plot(tout,wm_var*50,'Color',[0.65 0.65 0.65],'LineStyle','-.')

% ax = gca;
% ax.GridLineStyle = ':';
% xlabel('Time (s)')
% ylabel('Frequency (Hz)')
% legend({'CA u','CA w','Fix','Var'},'FontSize',14,'Orientation','horizontal','Location','Best')

%Save plot
set(gcf, 'Position', [100 100 700 350])
%  saveas(gcf,strcat('NLE_descbase'),'png')
%%
% Simulation compare.

clc
clear all
%%
dy_n = 0.03; % Delta y normalization [p.u.] 
du_n = 500;  % Delta u normalization [p.u.]
dk_n = dy_n/du_n;
%%
clear all
clc
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
load Kimc_d1_sce2-2
VSimMat_d_d1 = VSimMat_d;
Pdg_d_d1 = Pdg_d/1e3;
Qdg_d_d1 = Qdg_d/1e3;
tout_d_d1 = tout_d;
SP_d_d1 = SP_d;


load Kimc_s_sce2-2
VSimMat_d_s = VSimMat_d;
Pdg_d_s = Pdg_d/1e3;
Qdg_d_s = Qdg_d/1e3;
tout_d_s = tout_d;
SP_d_s = SP_d;

load Kimc_f_sce2-2
VSimMat_d_f = VSimMat_d;
Pdg_d_f = Pdg_d/1e3;
Qdg_d_f = Qdg_d/1e3;
tout_d_f = tout_d;
SP_d_f = SP_d;


Ts = tout_d(2)-tout_d(1);   
n_step = 8/Ts+1;
tt = tout_d(n_step:end)-tout_d(n_step);

% Buses Voltages
v14_d = VSimMat_d_d1(n_step:end,14);
v14_s = VSimMat_d_s(n_step:end,14);
v14_f = VSimMat_d_f(n_step:end,14);

% v9_d = VSimMat_d_d1(n_step:end,9);
% v9_s = VSimMat_d_s(n_step:end,9);
% v9_f = VSimMat_d_f(n_step:end,9);

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



% figure
% set(gcf, 'Position', [0 0 800 1050]);
% subplot(2,3,1),plot(tt,v14_d,tt,v14_s,tt,v14_f),grid on,xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('v_{14} (pu)'),xlim([5 15])
% legend('$\Gamma_{d}$','$\Gamma_{s}$','$\Gamma_{f}$','Interpreter','latex','FontSize',14) 
% subplot(2,3,2),plot(tt,v18_d,tt,v18_s,tt,v18_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{18}$ (pu)','Interpreter','latex','FontSize',14),xlim([5 15])
% subplot(2,3,3),plot(tt,v21_d,tt,v21_s,tt,v21_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{21}$ (pu)','Interpreter','latex','FontSize',14),xlim([5 15])
% subplot(2,3,4),plot(tt,v25_d,tt,v25_s,tt,v25_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{25}$ (pu)','Interpreter','latex','FontSize',14),xlim([5 15])
% subplot(2,3,5),plot(tt,v30_d,tt,v30_s,tt,v30_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{30}$ (pu)','Interpreter','latex','FontSize',14),xlim([5 15])
% subplot(2,3,6),plot(tt,v33_d,tt,v33_s,tt,v33_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{33}$ (pu)','Interpreter','latex','FontSize',14),xlim([5 15])


figure                                                                                             
set(gcf, 'Position', [900 0 800 1050]);                                                            
subplot(2,3,1),plot(tt,Qdg_1_d,tt,Qdg_1_s,tt,Qdg_1_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_1}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])     
legend('$\Gamma_{d}$','$\Gamma_{s}$','$\Gamma_{f}$','Interpreter','latex','FontSize',14)                                                   
subplot(2,3,2),plot(tt,Qdg_2_d,tt,Qdg_2_s,tt,Qdg_2_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_2}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])     
subplot(2,3,3),plot(tt,Qdg_3_d,tt,Qdg_3_s,tt,Qdg_3_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_3}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])     
subplot(2,3,4),plot(tt,Qdg_4_d,tt,Qdg_4_s,tt,Qdg_4_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_4}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])     
subplot(2,3,5),plot(tt,Qdg_5_d,tt,Qdg_5_s,tt,Qdg_5_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_5}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])     
subplot(2,3,6),plot(tt,Qdg_6_d,tt,Qdg_6_s,tt,Qdg_6_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_6}$ (kVAr)','Interpreter','latex','FontSize',14)%,xlim([8 15])
%xlim([5 15])
%%
clear all
clc
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


Ts = tout_d(2)-tout_d(1);   
n_step = 8/Ts+1;
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



figure
set(gcf, 'Position', [0 0 800 1050]);
subplot(2,3,1),plot(tt,v14_d,tt,v14_s,tt,v14_f),grid on,xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{14}$ (pu)','Interpreter','latex','FontSize',14)
legend('$\Gamma_{d}$','$\Gamma_{s}$','$\Gamma_{f}$','Interpreter','latex','FontSize',14) 
subplot(2,3,2),plot(tt,v18_d,tt,v18_s,tt,v18_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{18}$ (pu)','Interpreter','latex','FontSize',14)
subplot(2,3,3),plot(tt,v21_d,tt,v21_s,tt,v21_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{21}$ (pu)','Interpreter','latex','FontSize',14)
subplot(2,3,4),plot(tt,v25_d,tt,v25_s,tt,v25_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{25}$ (pu)','Interpreter','latex','FontSize',14)
subplot(2,3,5),plot(tt,v30_d,tt,v30_s,tt,v30_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{30}$ (pu)','Interpreter','latex','FontSize',14)
subplot(2,3,6),plot(tt,v33_d,tt,v33_s,tt,v33_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$v_{33}$ (pu)','Interpreter','latex','FontSize',14)


figure                                                                                             
set(gcf, 'Position', [900 0 800 1050]);                                                            
subplot(2,3,1),plot(tt,Qdg_1_d,tt,Qdg_1_s,tt,Qdg_1_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_1}$ (kVAr)','Interpreter','latex','FontSize',14)
legend('$\Gamma_{d}$','$\Gamma_{s}$','$\Gamma_{f}$','Interpreter','latex','FontSize',14)                                                   
subplot(2,3,2),plot(tt,Qdg_2_d,tt,Qdg_2_s,tt,Qdg_2_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_2}$ (kVAr)','Interpreter','latex','FontSize',14)
subplot(2,3,3),plot(tt,Qdg_3_d,tt,Qdg_3_s,tt,Qdg_3_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_3}$ (kVAr)','Interpreter','latex','FontSize',14)  
subplot(2,3,4),plot(tt,Qdg_4_d,tt,Qdg_4_s,tt,Qdg_4_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_4}$ (kVAr)','Interpreter','latex','FontSize',14)     
subplot(2,3,5),plot(tt,Qdg_5_d,tt,Qdg_5_s,tt,Qdg_5_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_5}$ (kVAr)','Interpreter','latex','FontSize',14) 
subplot(2,3,6),plot(tt,Qdg_6_d,tt,Qdg_6_s,tt,Qdg_6_f),grid on, xlabel('time (s)','Interpreter','latex','FontSize',14),ylabel('$Q_{DG_6}$ (kVAr)','Interpreter','latex','FontSize',14)
