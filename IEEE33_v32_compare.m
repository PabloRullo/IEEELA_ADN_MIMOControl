%IEEE33_PSCAD

clc
clear all
close all


%% PI Voltage Control 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_ref_op_0 = [ 1.        , 0.99815495, 0.98914063, 0.98471028, 0.9804918 ,...
       0.96904474, 0.96641587, 0.96450788, 0.96249363, 0.96097774,...
       0.96091845, 0.96093938, 0.96081203, 0.96075773, 0.96056145,...
       0.96071036, 0.96128876, 0.96213622, 0.99793638, 0.99719819,...
       0.99726574, 0.99663155, 0.98645229, 0.98156405, 0.97998659,...
       0.96796432, 0.96658722, 0.9596496 , 0.9548537 , 0.9534103 ,...
       0.95131404, 0.9510419 , 0.95143906];

SP_0 = [v_ref_op_0(14), v_ref_op_0(18), v_ref_op_0(21), v_ref_op_0(25), v_ref_op_0(30), v_ref_op_0(33)];

%Sparse PI Structure:
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_mv1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_mv1'); %Sparse

% % Disturbance: 300-->100 kW Pdg_1
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_mv12'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_mv12'); %Sparse

% Set point change: 0.9621  -->0.9717  in v_17
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_mv12_sp'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_mv12_sp'); %Sparse

% with sparse loops restando
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_sp_a'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_sp_a'); %Sparse


%Set point change. Loss minimization operation point
v_ref_op_lm = [1.        , 0.99871207, 0.99245474, 0.9896249 , 0.98706464,...
       0.98150622, 0.9804685 , 0.97918698, 0.97906837, 0.97943713,...
       0.97954206, 0.97987292, 0.98263426, 0.98435804, 0.98449519,...
       0.9849807 , 0.98661631, 0.98779867, 0.99862516, 0.99902546,...
       0.99949375, 0.99886097, 0.9904867 , 0.98725229, 0.98729433,...
       0.9810247 , 0.98048204, 0.97882045, 0.97795824, 0.97795462,...
       0.97839283, 0.97905968, 0.98080953];
%    
  SP_1 = [v_ref_op_lm(14), v_ref_op_lm(18), v_ref_op_lm(21), v_ref_op_lm(25), v_ref_op_lm(30), v_ref_op_lm(33)];

% At same time
data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp'); %Descentralized
data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_dr1_sp'); %Sparse
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_sp'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_sp'); %Sparse

% One at once
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_sp_1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_sp_1'); %Sparse

% SP1 --> 0.96736
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp1'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp1'); %Sparse
% SP_1 = [0.96736 SP_0(2:end)];


% SP2 --> 0.9728
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp2'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp2'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp2'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp2'); %Sparse
% SP_1 = [SP_0(1) 0.9728 SP_0(3:end)];


% SP3 --> 1.0035
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp3'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp3'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp3'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp3'); %Sparse
% SP_1 = [SP_0(1:2) 1.0035 SP_0(4:end)];


% SP4 --> 0.9862
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp4'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp4'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp4'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp4'); %Sparse
% SP_1 = [SP_0(1:3) 0.9862 SP_0(5:end)];

% SP5 --> 0.9572
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp5'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp5'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp5'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp5'); %Sparse
% SP_1 = [SP_0(1:4) 0.9572 SP_0(end)];

% SP5 --> 0.9575
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_sd_sp6'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_ss_sp6'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_sp6'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_sp6'); %Sparse

% % Disturbance: 300-->0 kW Pdg_i i=1, ..., 6

% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v3_sd_d'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v3_ss_d'); %Sparse
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d1'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d1'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d1'); %Sparse

% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d2'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d2'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d2'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d2'); %Sparse

% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d3'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d3'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d3'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d3'); %Sparse

% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d4'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d4'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d4'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d4'); %Sparse

% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d5'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d5'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d5'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d5'); %Sparse

% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_d6'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_d6'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_d6'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_d6'); %Sparse

%At same time
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_da'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_da'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_da'); %Sparse
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_da'); %Sparse

% One at once

% data_d = load_IEEE33_PSCADdata_v3_s('sd_d_1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ss_d_1'); %Sparse

%%%%%%%%%%%%%%%%%%%%%%%%%
% Load trip
% Load (n1)
% % 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl1'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl1'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl1'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl1'); %Sparse 3

% Load (n2)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl2'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl2'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl2'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl2'); %Sparse 3

% Load (n5)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl5'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl5'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl5'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl5'); %Sparse 3

% Load (n7)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl7'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl7'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl7'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl7'); %Sparse 3

% Load (n8)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_dl8'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_dl8'); %Sparse

% % Load (n9)
% % 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_dl9'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_dl9'); %Sparse

% Load (n13)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_dl13'); %Descentralized
% % data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_dl13'); %Sparse
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_dr1_dl13'); %droop

% Load (n15)
%   
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl15'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl15'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl15'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl15'); %Sparse 3

% Load (n21)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl21'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl21'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl21'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl21'); %Sparse 3


% Load (n23)
% 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v31_sd_dl23'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v31_ss_dl23'); %Sparse
% data_s2 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss2_dl23'); %Sparse 2
% data_s3 = load_IEEE33_PSCADdata_v3_s2('ieee33_v31_ss3_dl23'); %Sparse 3


% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_opla'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_opla'); %Sparse

% % Load (n29)
% % 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_dl29'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_dl29'); %Sparse

% % Load (n31)
% % 
% data_d = load_IEEE33_PSCADdata_v3_s('ieee33_v32_sd_dl31'); %Descentralized
% data_s = load_IEEE33_PSCADdata_v3_s('ieee33_v32_ss_dl31'); %Sparse
%% time vector
Ts = data_d.t(2)-data_d.t(1);
n_step = 0/Ts;
ni = n_step +1;
tt = data_d.t(ni:end)-data_d.t(ni);
%%
% Loop 1 (y1-u1) // v_13 - Qdg1_ref(B13)
v_13_d =  data_d.v_13(ni:end);
v_13_s =  data_s.v_13(ni:end);

% Qref_1_d = data_d.qrif_pi_t_1(ni:end);
% Qref_1_s = data_s.qrif_pi_t_1(ni:end);
mv_1_d = data_d.Q_dg1(ni:end);
mv_1_s = data_s.Q_dg1(ni:end);

% node voltage
% figure
% plot(tt,v_13_d,tt,v_13_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{13} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on0.9621
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_1_d,tt,mv_1_s),grid on
% xlabel('time (s)')
% ylabel('mv_1 Qdg_1 (kVAr)')
% legend('Desc','Sparse')

%%
% Loop 2 // v_17 (v_13) - Qdg2_ref(B17)
v_17_d =  data_d.v_17(ni:end);
v_17_s =  data_s.v_17(ni:end);


mv_2_d = data_d.Q_dg2(ni:end);
mv_2_s = data_s.Q_dg2(ni:end);

% node voltage
% figure
% plot(tt,v_17_d,tt,v_17_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{17} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_2_d,tt,mv_2_s),grid on
% xlabel('time (s)')
% ylabel('mv_2 Qdg_2 (kVAr)')
% legend('Desc','Sparse')
%%
% Loop 3 // v_20 - Qdg3_ref(B20)
v_20_d =  data_d.v_20(ni:end);
v_20_s =  data_s.v_20(ni:end);


mv_3_d = data_d.Q_dg3(ni:end);
mv_3_s = data_s.Q_dg3(ni:end);
% node voltage
% figure
% plot(tt,v_20_d,tt,v_20_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{20} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_3_d,tt,mv_3_s),grid on
% xlabel('time (s)')
% ylabel('mv_3 Qdg_3 (kVAr)')
% legend('Desc','Sparse')
%%
% Loop 4 // v_24 - Qdg4_ref(B24)
v_24_d =  data_d.v_24(ni:end);
v_24_s =  data_s.v_24(ni:end);


mv_4_d = data_d.Q_dg4(ni:end);
mv_4_s = data_s.Q_dg4(ni:end);

% node voltage
% figure
% plot(tt,v_24_d,tt,v_24_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{24} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_4_d,tt,mv_4_s),grid on
% xlabel('time (s)')
% ylabel('mv_4 Qdg_4 (kVAr)')
% legend('Desc','Sparse')

%%
% Loop 5 // v_29 (v_32) - Qdg5_ref(B29)
v_29_d =  data_d.v_29(ni:end);
v_29_s =  data_s.v_29(ni:end);


mv_5_d = data_d.Q_dg5(ni:end);
mv_5_s = data_s.Q_dg5(ni:end);


% node voltage
% figure
% plot(tt,v_29_d,tt,v_29_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{29} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_5_d,tt,mv_5_s),grid on
% xlabel('time (s)')
% ylabel('mv_5 Qdg_5 (kVAr)')
% legend('Desc','Sparse')
%%
% Loop 6 // v_32 (v_29) - Qdg6_ref(B29)
v_32_d =  data_d.v_32(ni:end);
v_32_s =  data_s.v_32(ni:end);


mv_6_d = data_d.Q_dg6(ni:end);
mv_6_s = data_s.Q_dg6(ni:end);

% node voltage
% figure
% plot(tt,v_32_d,tt,v_32_s),grid on
% legend('Desc','Sparse')
% xlabel('time (s)')
% ylabel('v_{32} (pu)')

% %PI error
% figure
% plot(tt,ev_pi_1),grid on
% xlabel('time (s)')
% ylabel('ev_{pi_1} (pu)')
% % ylim([0.9 1.2])

%MV1
% figure
% plot(tt,mv_6_d,tt,mv_6_s),grid on
% xlabel('time (s)')
% ylabel('mv_6 Qdg_6 (kVAr)')
% legend('Desc','Sparse')
%%
%Plot Subfigures
% figure
% set(gcf, 'Position', [0 0 800 1050]);
% subplot(2,3,1),plot(tt,v_13_d,tt,v_13_s),grid on,xlabel('time (s)'),ylabel('v_{13} (pu)')
% legend('\Gamma_{dlo}','\Gamma_{sd}')
% subplot(2,3,2),plot(tt,v_17_d,tt,v_17_s),grid on, xlabel('time (s)'),ylabel('v_{17} (pu)')
% subplot(2,3,3),plot(tt,v_20_d,tt,v_20_s),grid on, xlabel('time (s)'),ylabel('v_{20} (pu)')
% subplot(2,3,4),plot(tt,v_24_d,tt,v_24_s),grid on, xlabel('time (s)'),ylabel('v_{24} (pu)')
% subplot(2,3,5),plot(tt,v_29_d,tt,v_29_s),grid on, xlabel('time (s)'),ylabel('v_{29} (pu)')
% subplot(2,3,6),plot(tt,v_32_d,tt,v_32_s),grid on, xlabel('time (s)'),ylabel('v_{32} (pu)')

figure
set(gcf, 'Position', [0 0 800 1050]);
subplot(2,3,1),plot(tt,v_13_d,tt,v_13_s),grid on,xlabel('time (s)'),ylabel('v_{13} (pu)')
legend('\Gamma_{sd}','\Gamma_{ss}')
subplot(2,3,2),plot(tt,v_17_d,tt,v_17_s),grid on, xlabel('time (s)'),ylabel('v_{17} (pu)')
subplot(2,3,3),plot(tt,v_20_d,tt,v_20_s),grid on, xlabel('time (s)'),ylabel('v_{20} (pu)')
subplot(2,3,4),plot(tt,v_24_d,tt,v_24_s),grid on, xlabel('time (s)'),ylabel('v_{24} (pu)')
subplot(2,3,5),plot(tt,v_29_d,tt,v_29_s),grid on, xlabel('time (s)'),ylabel('v_{29} (pu)')
subplot(2,3,6),plot(tt,v_32_d,tt,v_32_s),grid on, xlabel('time (s)'),ylabel('v_{32} (pu)')

% 
figure                                                                                             
set(gcf, 'Position', [900 0 800 1050]);                                                            
subplot(2,3,1),plot(tt,mv_1_d,tt,mv_1_s),grid on, xlabel('time (s)'),ylabel('Qdg_1 (kVAr)')     
legend('\Gamma_{dlo}','\Gamma_{ss1}')                                                   
subplot(2,3,2),plot(tt,mv_2_d,tt,mv_2_s),grid on, xlabel('time (s)'),ylabel('Qdg_2 (kVAr)')     
subplot(2,3,3),plot(tt,mv_3_d,tt,mv_3_s),grid on, xlabel('time (s)'),ylabel('Qdg_3 (kVAr)')     
subplot(2,3,4),plot(tt,mv_4_d,tt,mv_4_s),grid on, xlabel('time (s)'),ylabel('Qdg_4 (kVAr)')     
subplot(2,3,5),plot(tt,mv_5_d,tt,mv_5_s),grid on, xlabel('time (s)'),ylabel('Qdg_5 (kVAr)')     
subplot(2,3,6),plot(tt,mv_6_d,tt,mv_6_s),grid on, xlabel('time (s)'),ylabel('Qdg_6 (kVAr)')     
                                                                                                   

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAE Calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Distrubance

% sp1 = SP_0(1)*ones(1,length(tt))';
% iae1_d = sum(abs(sp1-v_13_d));
% iae1_s = sum(abs(sp1-v_13_s));
% sp2 = SP_0(2)*ones(1,length(tt))';
% iae2_d = sum(abs(sp2-v_17_d));
% iae2_s = sum(abs(sp2-v_17_s));
% sp3 = SP_0(3)*ones(1,length(tt))';
% iae3_d = sum(abs(sp3-v_20_d));
% iae3_s = sum(abs(sp3-v_20_s));
% sp4 = SP_0(4)*ones(1,length(tt))';
% iae4_d = sum(abs(sp4-v_24_d));
% iae4_s = sum(abs(sp4-v_24_s));
% sp5 = SP_0(5)*ones(1,length(tt))';
% iae5_d = sum(abs(sp5-v_29_d));
% iae5_s = sum(abs(sp5-v_29_s));
% sp6 = SP_0(6)*ones(1,length(tt))';
% iae6_d = sum(abs(sp6-v_32_d));
% iae6_s = sum(abs(sp6-v_32_s));

%%%%%%% Set Point change

% sp1 = [SP_0(1)*ones(1,1/Ts) SP_1(1)*ones(1,9/Ts)]';
% iae1_d = sum(abs(sp1-v_13_d));
% iae1_s = sum(abs(sp1-v_13_s));
% sp2 = [SP_0(2)*ones(1,1/Ts) SP_1(2)*ones(1,9/Ts)]';
% iae2_d = sum(abs(sp2-v_17_d));
% iae2_s = sum(abs(sp2-v_17_s));
% sp3 = [SP_0(3)*ones(1,1/Ts) SP_1(3)*ones(1,9/Ts)]';
% 
% iae3_d = sum(abs(sp3-v_20_d));
% iae3_s = sum(abs(sp3-v_20_s));
% sp4 = [SP_0(4)*ones(1,1/Ts) SP_1(4)*ones(1,9/Ts)]';
% iae4_d = sum(abs(sp4-v_24_d));
% iae4_s = sum(abs(sp4-v_24_s));
% sp5 = [SP_0(5)*ones(1,1/Ts) SP_1(5)*ones(1,9/Ts)]';
% iae5_d = sum(abs(sp5-v_29_d));
% iae5_s = sum(abs(sp5-v_29_s));
% sp6 = [SP_0(6)*ones(1,1/Ts) SP_1(6)*ones(1,9/Ts)]';
% iae6_d = sum(abs(sp6-v_32_d));
% iae6_s = sum(abs(sp6-v_32_s));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Control Energy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ll = length(mv_1_d);
mv_max = 500;
% mv1
Eu_mv1_sd = sum(((mv_1_d-mv_1_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv1_ss1 = sum(((mv_1_s-mv_1_s(1)*ones(ll,1))./mv_max).^2);


%mv2
Eu_mv2_sd =  sum(((mv_2_d -mv_2_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv2_ss1 = sum(((mv_2_s -mv_2_s(1)*ones(ll,1))./mv_max).^2);


%mv3
Eu_mv3_sd =  sum(((mv_3_d -mv_3_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv3_ss1 = sum(((mv_3_s -mv_3_s(1)*ones(ll,1))./mv_max).^2);


%mv4
Eu_mv4_sd =  sum(((mv_4_d -mv_4_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv4_ss1 = sum(((mv_4_s -mv_4_s(1)*ones(ll,1))./mv_max).^2);


%mv5
Eu_mv5_sd =  sum(((mv_5_d -mv_5_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv5_ss1 = sum(((mv_5_s -mv_5_s(1)*ones(ll,1))./mv_max).^2);


%mv6
Eu_mv6_sd =  sum(((mv_6_d -mv_6_d(1)*ones(ll,1))./mv_max).^2);
Eu_mv6_ss1 = sum(((mv_6_s -mv_6_s(1)*ones(ll,1))./mv_max).^2);


%%
run max_dev_v32.m