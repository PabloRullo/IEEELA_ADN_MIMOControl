% Plots NLE profile
run data_NLEprofile_ss2.m

%%
figure
plot(ad_comp,NLE_sp,'r--*'), hold on, grid on
plot(ad_comp,NLE_d,'b--o'), hold on, grid on
plot(ad_comp,NLE,'k-s'), hold on, grid on
xlabel('Additional model components')
ylabel('NLE value')
legend('NLE_{sp}', 'NLE_d', 'NLE')


