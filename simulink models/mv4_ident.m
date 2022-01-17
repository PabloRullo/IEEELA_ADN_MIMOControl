% Mv4: Qdg4_ref(B25)
P_dgf = 300*ones(1,6);
tPdg = 0.5*ones(1,6);

Q_dgf = zeros(1,6);
Q_dgf(4) = 100;  %kVAr
tQdg = 0.5*ones(1,6);

%simulate
sim('IEEE33BusTestSystem_DG_Ident')
%%
% Output identification
Ts = tout_d(2)-tout_d(1);
n_step = 1/Ts;
tt = tout_d(n_step+1:end)-tout_d(n_step+1);

% v_14
dv_v14n_aux = (VSimMat_d(:,14) - VSimMat_d(10,14))/dy_n;
dv_v14n =  dv_v14n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,14) - VSimMat_d(10,14))/(Q_dgf(4) - Q_dg0(4));
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g14 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v14n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')

% v_18
dv_v18n_aux = (VSimMat_d(:,18) - VSimMat_d(10,18))/dy_n;
dv_v18n =  dv_v18n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,18) - VSimMat_d(10,18))/(Q_dgf(4) - Q_dg4_0);
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g24 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v18n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')

% v_21
dv_v21n_aux = (VSimMat_d(:,21) - VSimMat_d(10,21))/dy_n;
dv_v21n =  dv_v21n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,21) - VSimMat_d(10,21))/(Q_dgf(4) - Q_dg4_0);
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g34 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v21n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')

% v_25
dv_v25n_aux = (VSimMat_d(:,25) - VSimMat_d(10,25))/dy_n;
dv_v25n =  dv_v25n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,25) - VSimMat_d(10,25))/(Q_dgf(4) - Q_dg4_0);
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g44 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v25n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')
% 
% v_30
dv_v30n_aux = (VSimMat_d(:,30) - VSimMat_d(10,30))/dy_n;
dv_v30n =  dv_v30n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,30) - VSimMat_d(10,30))/(Q_dgf(4) - Q_dg4_0);
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g54 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v30n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')

% v_33
dv_v33n_aux = (VSimMat_d(:,33) - VSimMat_d(10,33))/dy_n;
dv_v33n =  dv_v33n_aux(n_step+1:end);
%g11 = K / (tau*s + 1) // dQdg4_ref = 100/500 = 0.2 
kp = (VSimMat_d(end,33) - VSimMat_d(10,33))/(Q_dgf(4) - Q_dg4_0);
kpn = kp/dk_n;
Tp = 0.05;

num = [kpn];
den = [Tp 1];
sys = tf(num,den);
g64 = sys;
v_iden = 0.2*step(sys,tt);% dQdg4_ref = 100/500 

% figure
% plot(tt,dv_v33n,tt,v_iden), grid on
% legend('y','y_{iden}')
% xlabel('time (s)')
% ylabel('y')