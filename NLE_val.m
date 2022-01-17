function [NLE_sp,NLE_d,NLE,structure,obj] = NLE_val(CVs,G,D,qa)
q0 = length(CVs);

Gs = G(CVs,:);
Ds = D(CVs,:);


%%

% PARAMETROS GA
%%%%%%%%%%%%%%%
pop=[];%crtbp(1000, 20, 2); 

nvars = q0^2-q0; %matriz completa menos el descentralizado base
% qa = 7; %qa: elementos adicionales. qa=0 (libre, óptimo), 0<qa<=nvars (fija la cantidad de componentes adicionales)


% OPCIONES
%%%%%%%%%%
K = 10000; %population size
options = gaoptimset;
options = gaoptimset(options,'PopulationType', 'bitstring');
options = gaoptimset(options,'PopulationSize', K);
% options = gaoptimset(options,'MigrationFraction', 0.5);
% options = gaoptimset(options,'MigrationInterval', 1);
%options = gaoptimset(options,'TolFun', 0.1);
% options = gaoptimset(options,'MaxStallGenerations', 3);
%options = gaoptimset(options,'DistanceMeasureFcn', {@distancecrowding,'genotype'});
options = gaoptimset(options,'Generations', 25);
%options = gaoptimset(options,'MutationFcn', {  @mutationuniform [] });
options = gaoptimset(options,'Display', 'iter');
% options = gaoptimset(options,'PlotFcns', { @gaplotpareto });
% options = gaoptimset(options,'Vectorized', 'on');
 options = gaoptimset(options,'UseParallel', true);

%Create initial population matrix with qa ones
if qa ~= 0 
    pop_ini = zeros(K,nvars);
    for i=1:K
        pop_ini(i,randsample(nvars,qa))=1;
    end
    options = gaoptimset(options,'InitialPopulation', pop_ini);
end
%%

% LLAMADO A gamultiobj
%%%%%%%%%%%%%%%%%%%%%%
tic 
[x,fval,exitflag,output,population,score] = ga(@(pop)function_val_nle(pop,Gs,Ds,q0,qa),nvars,[],[],[],[],[],[],[],[],options);
toc
%%

% MOSTRAR INDICES FINALES
%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('The number of points on the Pareto front was: %d\n', size(x,1));
% fprintf('The number of generations was : %d\n', output.generations);
% fprintf('The spread measure of the Pareto front was: %g\n', output.spread);


% Costos Finales
%%%%%%%%%%%%%%%%%
structure = eye(q0);
Ind_raw = x;
Ind = [1 Ind_raw(1:6) 1  Ind_raw(7:12) 1 Ind_raw(13:18) 1 Ind_raw(19:24) 1 Ind_raw(25:30) 1];
idx = logical(Ind);
structure(idx) = 1
qa_opt = sum(x);
fprintf('Number of additional components: %d\n', qa_opt);

Gvs = Gs.*structure;

SS=eye(q0)-Gvs*(Gs^-1);
SSS=Gvs*(Gs^-1)*Ds;
NLE_sp = norm(SS,'fro')^2;
NLE_d = norm(SSS,'fro')^2;
NLE = NLE_sp + NLE_d;

%%
%Seleccion de CVs y MVs
n = size(G,1); %number of outputs (potential CVs)
m = size(G,2); %number of outputs (potential MVs)

sel_CVs = zeros(1,n);
sel_MVs = ones(1,m);

sel_CVs(CVs) = 1;


idx_cvs = logical(sel_CVs);
idx_mvs = logical(sel_MVs);


Gr = G(not(idx_cvs),idx_mvs);

% Perturbaciones
Ds = D(idx_cvs,:);
Dr = D(not(idx_cvs),:);
%SSD
AA = Gr*((Gs)^-1);
BB = Dr-(Gr*((Gs)^-1)*Ds);
SSD_sp = norm(AA,'fro')^2;
SSD_d = norm(BB,'fro')^2;
SSD = SSD_sp + SSD_d;
%%
C_ssd = 1; % C_ssd weigth
C_nle = 1; % C_nle weigth
C_ssd_sp = 1;
C_ssd_d = 1;
C_nle_sp = 1;
C_nle_d = 1;


obj = C_ssd*(C_ssd_sp*SSD_sp + C_ssd_d*SSD_d) + C_nle*(C_nle_sp*NLE_sp + C_nle_d*NLE_d);
