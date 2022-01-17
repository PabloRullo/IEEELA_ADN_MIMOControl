%Disturbance OP
P_dgf = 300*ones(1,6);
tPdg = 0.5*ones(1,6);


for j=1:6 %MVs
    
    Q_dgf = zeros(1,6);
    Q_dgf(j) = 400;  %kVAr
    tQdg = 0.5*ones(1,6);
    
    %simulate
    sim('IEEE33BusTestSystem_DG_Ident')
    %%
    for i=1:length(CVs_sel)
        cv_i = CVs_sel(i);
        % Output identification
        Ts = tout_d(2)-tout_d(1);
        n_step = 0.5/Ts;
        tt = tout_d(n_step+1:end)-tout_d(n_step+1);
        
        % v_i
        dv_vin_aux = (VSimMat_d(:,cv_i) - VSimMat_d(10,cv_i))/dy_n;
        dv_vin =  dv_vin_aux(n_step+1:end);
        %g11 = K / (tau*s + 1) // dQdg1_ref = 100/500 = 0.2
        kp = (VSimMat_d(end,cv_i) - VSimMat_d(10,cv_i))/(Q_dgf(j) - Q_dg0(j));
        kpn = kp/dk_n;
        Tp = 0.05;
        
        num = [kpn];
        den = [Tp 1];
        sys = tf(num,den);
        Gn(i,j) = sys;
        v_iden = (Q_dgf(j)/du_n)*step(sys,tt);% dQdg1_ref = 100/500
        
        %
        % figure
        % plot(tt,dv_vin,tt,v_iden), grid on
        % legend('y','y_{iden}')
        % xlabel('time (s)')
        % ylabel('y')
        % title(['CV: v_{' num2str(cv_i) '}'])
    end
end