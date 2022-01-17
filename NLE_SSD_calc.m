 % COMENTARIOS GENERALES
%%%%%%%%%%%%%%%%%%%%%%%
% The initial population is generated randomly by default
%Two options 'ParetoFraction' and 'DistanceFcn' are used to control the elitism. 
%The Pareto fraction option limits the number of individuals on the Pareto front (elite members) 
%and the distance function helps to maintain diversity on a front by favoring individuals that are relatively far away on the front.

clear;
close all;
clc;
%%

% PARAMETROS GENERALES
%%%%%%%%%%%%%%%%%%%%%%

%read .csv
% Gcsv = readtable('Datos_G_IEEE33_0-01.csv');
% Dcsv = readtable('Datos_De_IEEE33_0-01.csv');

%SS gain matrix
% dist_load = [1 2 7 13 21 23 29 31]; % 1,2 + max deviation por rama
% dist_load = [29 31 13 7 6 30 17 28 24 23]; %10 most dev
% dist_load = [1 2]; % 5 most dev

% dist_col = [1:6,dist_load+6];
% dist_col = [dist_load+6];
% G = Gcsv{:,:};
% % D = Dcsv{:,dist_col};
% D = Dcsv{:,:};

load SS_matrix_matpower_GD_dy0-03.mat
G = Gn;
D = Dn;

%Seleccion de CVs y MVs
CVs = [14 18 21 25 30 33];
q0 = length(CVs);
% 57.9502 59.710 57.9533
Gs = G(CVs,:);
Ds = D(CVs,:);
s_sp_1 =  (Gs^-1)*eye(q0);
structure = [1 0 0 0 0 0;
             0 1 0 0 0 0;
             0 0 1 0 0 0;
             0 0 0 1 0 0;
             0 0 0 0 1 0;
             0 0 0 0 0 1];
         
Gvs = Gs.*structure;


%%
%Seleccion de CVs y MVs
n = size(G,1); %number of outputs (potential CVs)
m = size(G,2); %number of outputs (potential MVs)

sel_CVs = zeros(1,n);
sel_MVs = ones(1,m);

sel_CVs(CVs) = 1;


idx_cvs = logical(sel_CVs);
idx_mvs = logical(sel_MVs);


Gr = G(not(idx_cvs),idx_mvs);

% Perturbaciones
Ds = D(idx_cvs,:);
Dr = D(not(idx_cvs),:);

%SSD
AA = Gr*((Gs)^-1);
BB = Dr-(Gr*((Gs)^-1)*Ds);
SSD_sp = norm(AA,'fro')^2
SSD_d = norm(BB,'fro')^2
SSD = SSD_sp + SSD_d

%NLE
SS=eye(q0)-Gvs*(Gs^-1);
SSS=Gvs*(Gs^-1)*Ds;
NLE_sp = norm(SS,'fro')^2
NLE_d = norm(SSS,'fro')^2
NLE = NLE_sp + NLE_d


C_ssd = 1; % C_ssd weigth
C_nle = 1; % C_nle weigth
C_ssd_sp = 1;
C_ssd_d = 1;
C_nle_sp = 1;
C_nle_d = 1;


obj = C_ssd*(C_ssd_sp*SSD_sp + C_ssd_d*SSD_d) + C_nle*(C_nle_sp*NLE_sp + C_nle_d*NLE_d)

us_sp =  (Gs^-1)*eye(q0)
us_d = (Gs^-1)*Ds*eye(q0)
yr_sp = AA
yr_d = BB
%%
% Control analysis
% RGAn = Gn.*(pinv(Gn)');
% rsum = sum(RGAn,2);
% GG = Gn(dg_i,:);
% RGA_ss = GG.*(GG^-1)';

[U,S,V]=svd(Gs);
cond_number = cond(Gs);
sinval_G = svd(G)
sinval_Gs_nq6 = svd(Gs)
sinval_Gvs_desc_nq6 = svd(Gvs)

% RGAno_ss= sum(sum(abs(RGA_ss - eye(6))));% RGAnumber
% NI_1 = det(GG)/prod(diag(GG));  %Niederlinski index
