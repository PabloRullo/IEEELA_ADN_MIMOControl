function [NLE_sp,NLE_d,SSD_sp,SSD_d,structure,ind_cvs,ind_mvs] = SSD_NLE_val(G,D,q0,qa)
%Seleccion de CVs y MVs
n = size(G,1); %number of outputs (potential CVs)
m = size(G,2); %number of outputs (potential MVs)

% q0 = 6; % number of MVs,CVs.
% qa = 0; %qa: elementos adicionales. qa=0 (libre, óptimo), 0<qa<=nvars (fija la cantidad de componentes adicionales)

% PARAMETROS GA
%%%%%%%%%%%%%%%
pop=[];
% number of CVs > number of MVs
if qa == -1 %(desc)
    nvars = n+m;
else
    n_qa = q0^2-q0; %matriz completa menos el descentralizado base
    % nvars = (n+(m-q0)+n_qa); %Cantidad de variables de optimizacion. Longitud de cromosoma.
    nvars = (n+m+q0^2-q0); %Cantidad de variables de optimizacion. Longitud de cromosoma. (con elección libre de MVs)
end

% OPCIONES
%%%%%%%%%%
K = 1000; %population size
options = gaoptimset;
options = gaoptimset(options,'PopulationType', 'bitstring');
options = gaoptimset(options,'PopulationSize', K);
% options = gaoptimset(options,'MigrationFraction', 0.5);
% options = gaoptimset(options,'MigrationInterval', 1);
%options = gaoptimset(options,'TolFun', 0.1);
% options = gaoptimset(options,'MaxStallGenerations', 3);
%options = gaoptimset(options,'DistanceMeasureFcn', {@distancecrowding,'genotype'});
options = gaoptimset(options,'Generations', 30);
%options = gaoptimset(options,'MutationFcn', {  @mutationuniform [] });
options = gaoptimset(options,'Display', 'iter');
% options = gaoptimset(options,'PlotFcns', { @gaplotpareto });
% options = gaoptimset(options,'Vectorized', 'on');
 options = gaoptimset(options,'UseParallel', true);

%Create initial population matrix with qa ones
    pop_ini = zeros(K,nvars);
   
    for i=1:K
%         if n_qa == 0
%              pop_ini(i,[randsample(n,q0); n+randsample(m,q0)])=1;
%         else
%         pop_ini(i,[randsample(n,q0); n+randsample(n_qa,qa)])=1;
        if qa == -1
            pop_ini(i,[randsample(n,q0); n+randsample(m,q0)])=1;
        else
            pop_ini(i,[randsample(n,q0); n+randsample(m,q0); n+m+randsample(n_qa,randi(n_qa+1)-1)])=1;
        end
%         end
    end
    options = gaoptimset(options,'InitialPopulation', pop_ini);
%%

% LLAMADO A gamultiobj
%%%%%%%%%%%%%%%%%%%%%%
% Ingresar a function_val_ssd_nle.m para especificar la selección 
tic 
[x,fval,exitflag,output,population,score] = ga(@(pop)function_val_ssd_nle(pop,G,D,q0,qa),nvars,[],[],[],[],[],[],[],[],options);
toc
%%

% Costos Finales
%%%%%%%%%%%%%%%%%

Ind_raw = x; %cromosoma crudo (concentrado)
% Ind=[Ind_raw(1:n) 1 1 1 1 1 1 Ind_raw(n+1:end)];
Ind = Ind_raw;

idx_cvs = logical(Ind(1:n));
idx_mvs = logical(Ind(n+1:n+m));
% Model Sel
Gs = G(idx_cvs,idx_mvs);
%Pairing
[B,perm,flp,ct]=b3muRGA(Gs,'true');
a=size(perm);
if a(1,1) > 0
    Fact=1;
    %                    RGAs1 = B(end,2); %menor RGAsum
    %                    %RGAs1 = B(1,1); %menor mu
    permutac1 = perm(end,:); %perm. ordenada de las vi
    Gs_ord = Gs(:,permutac1); % Gs ordenada menor RGAn
end

ind_cvs = find(Ind(1:n));
ind_mvs = find(Ind(n+1:n+m));

display(['Selected cvs (nodes): ', num2str(ind_cvs)]);
display(['Selected mvs (DGs): ', num2str(ind_mvs)]);
display(['MVs order for diagonal pairing: ',  num2str(permutac1)]);
if qa ~= -1
    qa_opt = sum(Ind(n+m+1:end));
else
    qa_opt = 0;
end
display(['Number of adttional comp: ', num2str(qa_opt)]);

structure = eye(q0);
if qa ~= -1
    idx_nd = logical(1-structure); %complete of diagonal index
    structure(idx_nd) = Ind(n+m+1:end) %of diagonal index for adittional components
end

display('Model parametrization:')                
structure


Gr = G(not(idx_cvs),idx_mvs);

Ds = D(idx_cvs,:);
Dr = D(not(idx_cvs),:);

Gvs = Gs.*structure;

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