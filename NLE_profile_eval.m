 % COMENTARIOS GENERALES
%%%%%%%%%%%%%%%%%%%%%%%

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

load  SS_matrix_matpower_GD_dy0-01.mat
G = Gn;
D = Dn;

%Seleccion de CVs y MVs
CVs = [14 18 21 25 30 33];
q0 = length(CVs);
qfull = q0^2-q0; %matriz completa menos el descentralizado base

for qi = 1:qfull
    [NLE_sp(qi),NLE_d(qi),NLE(qi),structure(:,:,qi),obj(qi)] = NLE_val(CVs,G,D,qi);
end
%%
ind = [1:qfull];

figure
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,NLE_sp,'-o'),
plot(ind,NLE_d,'-x')
legend('NLE','NLE_sp','NLE_d')
ylabel('value')
xlabel('ad comp')
