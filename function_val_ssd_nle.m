function scores = function_val_ssd_nle(pop,G,D,q0,qa) %vectorized function
    % function scores = vectorized_multiobjective_nle(pop,Gs,Ds,q0,qa)
    % Gs: SS gain matrix of subselected model.
    % Ds: SS disturbance matrix of subselected model.
    % q0: number of CVs, MVs.
    % qa: qa=0 (optimum), 0<qa<=nvars (fixed components)
    % scores = SSD + NLE = C_ssd*(SSD_sp + SSD_d) + C_nle*(NLE_sp + NLE_d)
    %  pop = [CVs | MVs | za ] (m:n:q0^²-q0)
    
    
    C_ssd = 1; % C_ssd weigth
    C_nle = 1; % C_nle weigth
    C_ssd_sp = 0;
    C_ssd_d = 1;
    C_nle_sp = 0;
    C_nle_d = 1;
    
    Nind = size(pop,1); % cant indiv population
    scores = zeros(Nind, 1); % initialize scores
     
    structure = eye(q0);
    
    n = size(G,1); %number of outputs (potential CVs)
    m = size(G,2); %number of outputs (potential MVs)
    ind_nle = m+n+1;
    
    for i=1:Nind
        Ind_raw = pop(i,:); %cromosoma crudo (concentrado)
%         Ind=[Ind_raw(1:n) 1 1 1 1 1 1 Ind_raw(n+1:end)]; %Cromosoma
%         fijando MVs.
      Ind = Ind_raw; %Cromosoma libre.
        
        
        if (sum(Ind(1:n))==q0) && (sum(Ind(n+1:n+m))==q0)%%
            
            idx_cvs = logical(Ind(1:n));
            idx_mvs = logical(Ind(n+1:n+m));

            Gs = G(idx_cvs,idx_mvs);

            if (det(Gs)~=0)
                
                Gr = G(not(idx_cvs),idx_mvs);
                
                % Perturbaciones
                Ds = D(idx_cvs,:);
                Dr = D(not(idx_cvs),:);
                %% SSD
                AA = Gr*((Gs)^-1);
                BB = Dr-(Gr*((Gs)^-1)*Ds);
                SSD_sp = norm(AA,'fro')^2;
                SSD_d = norm(BB,'fro')^2;
                SSD = SSD_sp + SSD_d;
                %% min RGAn - pairing
                [B,perm,flp,ct]=b3muRGA(Gs,'true');
                a=size(perm);
                if a(1,1) > 0
                    Fact=1;
                    %                    RGAs1 = B(end,2); %menor RGAsum
                    %                    %RGAs1 = B(1,1); %menor mu
                    permutac1 = perm(end,:); %perm. ordenada de las vi
                    Gs_ord = Gs(:,permutac1); % Gs ordenada menor RGAn
                    
                    %% NLE
                    if qa ~= -1
                        idx_nd = logical(1-structure); %complete of diagonal index
                        structure(idx_nd) = Ind(ind_nle:end); %of diagonal index for adittional components
                    end
                        
                    Gvs = Gs.*structure;
                    
                    %% Testeo de estabilidad Garcia and Morari
                    GGG = Gs*(Gvs^-1);
                    autoval = eig(GGG);
                    r_autoval = real(autoval);
                    testeo = (r_autoval>0);
                    
                    if (sum(testeo)==q0)
                        SS=eye(q0)-Gvs*(Gs^-1);
                        SSS=Gvs*(Gs^-1)*Ds;
                        NLE_sp = norm(SS,'fro')^2;
                        NLE_d = norm(SSS,'fro')^2;
                        scores(i) = C_ssd*(C_ssd_sp*SSD_sp + C_ssd_d*SSD_d) + C_nle*(C_nle_sp*NLE_sp + C_nle_d*NLE_d);
                    else
                        scores(i) = 1000; %infactible por morari
                    end
                    %% Restriccion de cantidad de componentes adic
                    if (qa ~= 0) && (qa ~= -1) &&  (sum(Ind) ~= (2*q0+qa)) %% fixed additional components
                        
                        scores(i) = 10000;
                    end
                else
                    Fact = 0; %infactible
                    scores(i) = inf; %infactible por ?
                end
            else
                scores(i) = inf; %infactible por det(Gs)~=0
                
            end
        else
            scores(i) = inf; %no se ajusta a q0
        end
    end
    
                
                    
                