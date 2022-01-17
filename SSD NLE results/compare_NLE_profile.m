clear all
clc
%%

% load NLE_profile_descbase_local_D_dy0-01.mat
load SSD_NLE_opt_profile_D_dy0-03

[m,i] = min(obj);

disp('Model: D - dy = 0.03 p.u.')
disp('Model parametrization:')
structure(:,:,i)
display(['Number of adttional comp: ', num2str(i-1)]);
display(['obj: ', num2str(obj(i))]);
display(['SSD: ', num2str(SSD(i))]);
display(['NLE: ', num2str(NLE(i))]);

ind = [0:qfull];
figure(1)
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-^'),
plot(ind,obj,'-x')
plot(i-1,obj(i),'o')
legend('NLE','SSD','NLE+SSD')
ylabel('value')
 %xlabel('Componentes adicionales del modelo')
 xlabel('Number of additional components')
 title('D dy=0.03')


figure(2)

plot(ind,NLE_sp,'--'), grid on, hold on
plot(ind,NLE_d,'-.'),
plot(ind,NLE,'-')
% plot(i-1,obj(i),'o')
legend('NLE_{sp}','NLE_d','NLE')
ylabel('valor')
xlabel('Componentes adicionales del modelo')


obj_opt = obj;
SSD_opt = SSD;
NLE_opt = NLE;

load NLE_profile_descbase_local_D_dy0-03
obj = [ 50.8376 obj];
ind = [0:qfull];
figure(3)
plot(ind,obj_opt,'-x'), grid on, hold on
plot(ind,obj,'-.o')
legend('v_{22}','v_{21}')
ylabel('valor')
xlabel('Componentes adicionales del modelo')
%%
load SSD_NLE_opt_profile_De_dy0-03


NLE = NLE_sp + NLE_d;
SSD = SSD_sp + SSD_d;
obj = NLE + SSD;

[m,i] = min(obj);

display('Model: De - dy = 0.03 p.u.')
display('Model parametrization:')
structure(:,:,i)
display(['Number of adttional comp: ', num2str(i-1)]);
display(['obj: ', num2str(obj(i))]);
display(['SSD: ', num2str(SSD(i))]);
display(['NLE: ', num2str(NLE(i))]);

ind = [0:qfull];
figure(2)
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-^'),
plot(ind,obj,'-x')
plot(i-1,obj(i),'o')
legend('NLE','SSD','obj','opt')
ylabel('value')
xlabel('ad comp')
title('De dy=0.03')

%%
load SSD_NLE_opt_profile_D_dy0-01

NLE = NLE_sp + NLE_d;
SSD = SSD_sp + SSD_d;
obj = NLE + SSD;

[m,i] = min(obj);

display('Model: D - dy = 0.01 p.u.')
display('Model parametrization:')
structure(:,:,i)
display(['Number of adttional comp: ', num2str(i-1)]);
display(['obj: ', num2str(obj(i))]);
display(['SSD: ', num2str(SSD(i))]);
display(['NLE: ', num2str(NLE(i))]);

ind = [0:qfull];
figure(3)
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-^'),
plot(ind,obj,'-x')
plot(i-1,obj(i),'o')
legend('NLE','SSD','obj','opt')
ylabel('value')
xlabel('ad comp')
title('D dy=0.01')

%%
load SSD_NLE_opt_profile_De_dy0-01


NLE = NLE_sp + NLE_d;
SSD = SSD_sp + SSD_d;
obj = NLE + SSD;

[m,i] = min(obj);

display('Model: De - dy = 0.01 p.u.')
display('Model parametrization:')
structure(:,:,i)
display(['Number of adttional comp: ', num2str(i-1)]);
display(['obj: ', num2str(obj(i))]);
display(['SSD: ', num2str(SSD(i))]);
display(['NLE: ', num2str(NLE(i))]);

ind = [0:qfull];
figure(4)
plot(ind,NLE,'-*'), grid on, hold on
plot(ind,SSD,'-^'),
plot(ind,obj,'-x')
plot(i-1,obj(i),'o')
legend('NLE','SSD','obj','opt')
ylabel('value')
xlabel('ad comp')
title('De dy=0.01')
