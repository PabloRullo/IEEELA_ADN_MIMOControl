function [NLE_sp,NLE_d,NLE] = NLE_calc(Gs,Gvs,Ds)

SS=eye(length(Gs))-Gvs*(Gs^-1); %NLE_sp
SSS=Gvs*(Gs^-1)*Ds; %NLE_d
NLE_sp = norm(SS,'fro')^2;
NLE_d = norm(SSS,'fro')^2;
NLE = NLE_sp + NLE_d;