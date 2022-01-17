% SSD_NLE_profile

clear;
close all;
clc;

%%
load  SS_matrix_matpower_GD_dy0-01.mat
G = Gn;
D = Dn;

q0 = 6; %grados de libertad seleccionados
qfull = q0^2-q0; %matriz completa menos el descentralizado base

for qi = 0:qfull
    qq = qi+1;
    if qi == 0
        [NLE_sp(qq),NLE_d(qq),SSD_sp(qq),SSD_d(qq),structure{qq},ind_cvs{qq},ind_mvs{qq}] = SSD_NLE_val(G,D,q0,-1);
    else
        [NLE_sp(qq),NLE_d(qq),SSD_sp(qq),SSD_d(qq),structure{qq},ind_cvs{qq},ind_mvs{qq}] = SSD_NLE_val(G,D,q0,qi);
    end
end


NLE = NLE_sp + NLE_d;
SSD = SSD_sp + SSD_d;
obj = NLE + SSD;

% save('SSD_NLE_opt_profile_D_dy0-01')
%%
load SSD_NLE_opt_profile_D_dy0-01
ind = [0:qfull];

figure
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-o'),
plot(ind,obj,'-x')
legend('NLE','SSD','obj')
ylabel('value')
xlabel('ad comp')
title('De dy=0.01')

