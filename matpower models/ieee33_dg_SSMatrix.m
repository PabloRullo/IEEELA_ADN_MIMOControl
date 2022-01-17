+% IEEE 33 with DG
clc
clear all
%%
%load original case
define_constants

mpc = case33bw;
%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
% DGs in buses [14,18,21,25,30,33]. (add as constant power loads)
% Pdg = 300 kW
mpc.bus(14,PD) = mpc.bus(14,PD)-0.3;
mpc.bus(18,PD) = mpc.bus(18,PD)-0.3;
mpc.bus(21,PD) = mpc.bus(21,PD)-0.3;
mpc.bus(25,PD) = mpc.bus(25,PD)-0.3;
mpc.bus(30,PD) = mpc.bus(30,PD)-0.3;
mpc.bus(33,PD) = mpc.bus(33,PD)-0.3;

%%
% Calculate sensitivities matrices (SS Gain matrices)
% Inverse of Jacobian matrix

% J = makeJac(mpc,1);
% 
% dQ_dVm = J(34:end,34:end);
% dP_dVm = J(1:33,34:end);
% 
% dVm_dQ = dQ_dVm^-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial values of v_i(V0)
results_0 = runpf(mpc,mpoption('verbose',0,'out.all',0));
V0 = results_0.bus(:,VM);
dg_i = [14,18,21,25,30,33];

% SS gain matrix (G)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_step = 0.2; 
% dVm/dQ, dQ = 0.2 MVAr
VQ = zeros(length(V0),length(dg_i));
for i=1:length(dg_i)
    mpc_dQ = mpc;
    mpc_dQ.bus(dg_i(i),QD) = mpc_dQ.bus(dg_i(i),QD) - Q_step;
    results_Q =runpf(mpc_dQ,mpoption('verbose',0,'out.all',0));
    VQ(:,i) = results_Q.bus(:,VM);   
    clear mpc_dQ
end

dVm = VQ-V0;
G = dVm/Q_step;         % SS Gain matrix
%%
% SS Disturbance matrix (D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d_i: active power of dg_i
P_step = 0.1; 

Srated = [0.1166,0.0985,0.1442,0.0671,0.0632,0.2236,0.2236,0.0632,0.0632,0.0541,0.0695,0.0695,0.1442,0.0608,0.0632,0.0632,0.0985,0.0985,0.0985,0.0985,0.0985,0.1030,0.4652,0.4652,0.0650,0.0650,0.0632,0.1389,0.6325,0.1655,0.2326,0.0721];
dl = 0;
Load_step = (dl-1)*Srated;


VP = zeros(length(V0),length(dg_i));
for i=1:length(dg_i)
    mpc_dP = mpc;
    mpc_dP.bus(dg_i(i),PD) = mpc_dP.bus(dg_i(i),PD) - P_step;
    results_P =runpf(mpc_dP,mpoption('verbose',0,'out.all',0));
    VP(:,i) = results_P.bus(:,VM);   
    clear mpc_dP
end
dVm_P = VP-V0;
Dp = dVm_P/P_step;         % SS Gain matrix


for i=1:length(Load_step)
        mpc_dL = case33bw;
        mpc_dL.bus(i,PD) = mpc_dL.bus(i,PD)*dl;
        mpc_dL.bus(i,QD) = mpc_dL.bus(i,QD)*dl;
        mpc_dL.bus(dg_i(1),PD) = mpc_dL.bus(dg_i(1),PD)-0.3;
        mpc_dL.bus(dg_i(2),PD) = mpc_dL.bus(dg_i(2),PD)-0.3;
        mpc_dL.bus(dg_i(3),PD) = mpc_dL.bus(dg_i(3),PD)-0.3;
        mpc_dL.bus(dg_i(4),PD) = mpc_dL.bus(dg_i(4),PD)-0.3;
        mpc_dL.bus(dg_i(5),PD) = mpc_dL.bus(dg_i(5),PD)-0.3;
        mpc_dL.bus(dg_i(6),PD) = mpc_dL.bus(dg_i(6),PD)-0.3;
        results_L =runpf(mpc_dL,mpoption('verbose',0,'out.all',0));
        VL(:,i) = results_L.bus(:,VM);
        dVm_L(:,i) =  VL(:,i) - V0;
        Dl(:,i) =  dVm_L(:,i)/Load_step(i);
        clear mpc_dL
end


%%
% normalization
dv_nf = 0.03;           % voltage normalization factor
dq_nf = 0.5;            % reactive power normalization factor
dp_nf = 0.3;
dl_nf = Srated;


G_nf = dv_nf/dq_nf;     %gain matrix normalization factor
Dp_nf = dv_nf/dp_nf;     %disturbance matrix normalization factor
Dl_nf = dv_nf./dl_nf;   %exte disturbance matrix normalization factor

%Normalized SS matrices
Gn = G/G_nf;
Dpn = Dp/Dp_nf;
Dln = Dl./Dl_nf;
Dn = Dpn;
Den = [Dpn Dln];
save('SS_matrix_matpower_GD_dy0-03.mat','Gn','Dn','Den')
%%
% Control analysis
% RGAn = Gn.*(pinv(Gn)');
% rsum = sum(RGAn,2);
% GG = Gn(dg_i,:);
% RGA_ss = GG.*(GG^-1)';
% 
% RGAno_ss= sum(sum(abs(RGA_ss - eye(6))));% RGAnumber
% NI_1 = det(GG)/prod(diag(GG));  %Niederlinski index