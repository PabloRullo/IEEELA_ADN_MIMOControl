% SSD_NLE Oversizing evaluation

clear;
close all;
clc;

%%
load  SS_matrix_matpower_GD_dy0-01.mat
G = Gn;
D = Dn;

n = size(G,1); %number of outputs (potential CVs)
m = size(G,2); %number of outputs (potential MVs)

qa = -1;
for q0 = 1:min(n,m)
    [NLE_sp(q0),NLE_d(q0),SSD_sp(q0),SSD_d(q0),structure{q0},ind_cvs{q0},ind_mvs{q0}] = SSD_NLE_val(G,D,q0,qa);
end
NLE = NLE_sp + NLE_d;
SSD = SSD_sp + SSD_d;
obj = NLE + SSD;
% save('SSD_NLE_oversizing_desc_D_dy0-01')

%%
load SSD_NLE_oversizing_desc_D_dy0-01.mat
ind = [1:min(n,m)];

figure
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-o'),
plot(ind,obj,'-x')
legend('NLE','SSD','obj')
ylabel('valor')
xlabel('n_q')
% title('De dy=0.03')
