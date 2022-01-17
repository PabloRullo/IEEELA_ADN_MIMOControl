clc
clear all

load IdenData
csvwrite('Datos_G_IEEE33.csv',G)
csvwrite('Datos_D_IEEE33.csv',D)



%%
% Descentralized local structure
G_dlo = G([14,18,21,25,30,33],:);
D_dlo = D([14,18,21,25,30,33],:);


% % SVD , model directions , condition number
% rank(G_dlo);
% [U,S,V]=svd(G_dlo);
% [U,S,V]=svd([G_dlo D_dlo]);

%Testeo de estabilidad Garcia and Morari
structure = eye(size(G_dlo));
Gvs = G_dlo.*structure;
GGG = G_dlo*(Gvs^(-1));
autoval = eig(GGG);
r_autoval = real(autoval);
testeo = (r_autoval>0);

% Chequeo estabilidad integral frente a falla de sensor/actuador (apertura
% del lazo)

for i=1:size(G_dlo,2) 
    G_dlo_a = G_dlo;
    G_dlo_a(i,:) = [];
    G_dlo_a(:,i) = [];
    Gvs_a = G_dlo_a.*eye(size(G_dlo_a));
    GGG_a = G_dlo_a*inv(Gvs_a);
    est_mor(:,i) = real(eig(GGG_a));
end

% cond_number = cond(G_dlo);
% 
% %limitation imposed by disturbances for perfect control
% for i=1:size(D_dlo,2)
%     upc(i,:)= abs(pinv(G_dlo)*D_dlo(:,i))';
% end
%%
% Chequeo estructuras de control
combinations = permn([0 1],30);
Gs = G_dlo;
Ds = D_dlo;

for i=1:length(combinations(:,1))
   structure_D1=[1 combinations(i,1:3);
              combinations(i,4) 1 combinations(i,5:6);
              combinations(i,7:8) 1 combinations(i,9);
              combinations(i,10:12) 1];
          
          
    Gvs = Gs.*structure_D1;
        % Testeo de estabilidad Garcia and Morari
    GGG = Gs*(Gvs^-1);
    autoval = eig(GGG);
    r_autoval = real(autoval);
    testeo = (r_autoval>0);
    
    if (det(Gvs)~=0) %(sum(testeo)==4)
        SS=eye(4)-Gvs*(Gs^-1);
        SSS=Gvs*(Gs^-1)*Ds;
        fitness1_D1(i) = norm(SS,'fro')^2;
        fitness2_D1(i) = norm(SSS,'fro')^2;
        fitness_D1(i) = fitness1_D1(i) + fitness2_D1(i);
    else
        fitness1_D1(i) = inf;
        fitness2_D1(i) = inf;
        fitness_D1(i) = inf;
    end
    

    real_min(i)= min(r_autoval);
    min_sv(i) = min(svd(Gvs));
    max_sv(i) = max(svd(Gvs));
    
    max_sv_sss(i) = max(svd(SSS.*0.05));

%     testeo = (r_autoval>0);
    if (sum(testeo)<4)
        unst(i) = 0; % inestable
    else
        unst(i) = 1; % estable
    end

end

% plot(fitness1)
% hold on
% plot(fitness2,'r')
% plot(fitness,'k')
[a_D1,b_D1]=sort(fitness_D1);
[a_D1;b_D1]';
% 
% figure
% plot(a,'-o')
% grid on
% ylabel('NLE')
% xlabel('Soluciones')
% 
% figure
% plot(unst(b),'-o')
% grid on
% ylabel('Test de robustez')
% xlabel('Soluciones')

a_D1(1:10)
combinations(b_D1(1:10),:)

%structure=[combinations(b(1),1:4);combinations(b(1),5:8);combinations(b(1),9:12);combinations(b(1),13:16)]

structure_D1 = [1 combinations(b_D1(1),1:3);
             combinations(b_D1(1),4) 1 combinations(b_D1(1),5:6);
             combinations(b_D1(1),7:8) 1 combinations(b_D1(1),9);
             combinations(b_D1(1),10:12) 1]