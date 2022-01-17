% IEEE 33 with DG
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
% mpc.bus(14,PD) = mpc.bus(14,PD)-0.3;
% mpc.bus(18,PD) = mpc.bus(18,PD)-0.3;
% mpc.bus(21,PD) = mpc.bus(21,PD)-0.3;
% mpc.bus(25,PD) = mpc.bus(25,PD)-0.3;
% mpc.bus(30,PD) = mpc.bus(30,PD)-0.3;
% mpc.bus(33,PD) = mpc.bus(33,PD)-0.3;

%% Define PF input matrix
% Generator matrix
Pdg_0 = 0.3;
n_dg = 6;
dg_i = [14,18,21,25,30,33];
for i = 2:n_dg+1 % row 1 is the substation (slack)
    mpc.gen(i,GEN_BUS) = dg_i(i-1);
    mpc.gen(i,PG) = Pdg_0;
    mpc.gen(i,QG) = 0;
    mpc.gen(i,QMAX) = 0.5;
    mpc.gen(i,QMIN) = -0.5;
    mpc.gen(i,GEN_STATUS) = 1;
    mpc.gen(i,PMAX) = Pdg_0;
    mpc.gen(i,PMIN) = Pdg_0;
end

% Loss minimization
% Generator cost data
% for i=1:2*(n_dg+1)
%     mpc.gencost(i,MODEL) = 2;
%     mpc.gencost(i,NCOST) = 1;
%     mpc.gencost(i,COST) = 1;
%     mpc.gencost(i,COST+1) = 0;
% end

% Minimization of substation power flow
%Cost of P and Q of substation
% mpc.gencost(1,COST) = 1000;
% mpc.gencost(n_dg+2,COST) = 1000;


% Minimize voltage deviation

nb = size(mpc.bus, 1);
ng = size(mpc.gen, 1);
%pag 67 y 68 Matpower manual
% u = Nx - r;
% with x = [theta Vm Pg Qg]'
% w = m*fd(u+-k)
% fd(alpha) = alpha if d=1; fd(alpha)=alpha^2 if d=2    
% fparm = [d r k m]
mpc.N = sparse(1:nb, nb+1:2*nb, 1, nb, 2*nb+2*ng);
mpc.fparm = ones(nb, 1) * [2 1 0 1];
mpc.Cw = ones(nb, 1); %ponderaracion con respecto a f(x)?
mpc.gencost = ones(ng, 1) * [2 0 0 2 0 0];  % zero out gen costs





% Calculate OPF
% values of v_i(V_lossmin)
results = runopf(mpc);
V_opf = results.bus(:,VM);

