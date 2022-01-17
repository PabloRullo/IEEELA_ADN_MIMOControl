function scores = function_val_nle(pop,Gs,Ds,q0,qa) %vectorized function
    % function scores = vectorized_multiobjective_nle(pop,Gs,Ds,q0,qa)
    % Gs: SS gain matrix of subselected model.
    % Ds: SS disturbance matrix of subselected model.
    % q0: number of CVs, MVs.
    % qa: qa=0 (optimum), 0<qa<=nvars (fixed components)
    % scores = NLE_sp + NLE_d
    
     a_d = 1; % NLE_d weigth
     a_sp = 1; % NLE_sp weigth
     
     Nind = size(pop,1); % cant indiv population
     scores = zeros(Nind, 1); % initialize scores
     
     structure = eye(q0);   
     
     
     for i=1:Nind
         Ind_raw = pop(i,:); %cromosoma crudo (concentrado)         
       
         Ind = [1 Ind_raw(1:6) 1  Ind_raw(7:12) 1 Ind_raw(13:18) 1 Ind_raw(19:24) 1 Ind_raw(25:30) 1];
         idx = logical(Ind);
         structure(idx) = 1;
         
         Gvs = Gs.*structure;
         
        % Testeo de estabilidad Garcia and Morari
        GGG = Gs*(Gvs^-1);
        autoval = eig(GGG);
        r_autoval = real(autoval);
        testeo = (r_autoval>0);
        
        if (det(Gvs)~=0) && (sum(testeo)==q0)
            SS=eye(q0)-Gvs*(Gs^-1);
            SSS=Gvs*(Gs^-1)*Ds;
            NLE_sp = norm(SS,'fro')^2;
            NLE_d = norm(SSS,'fro')^2;
            scores(i) = a_sp*NLE_sp + a_d*NLE_d;
        else
            scores(i) = inf;
        end
    
        if (qa ~= 0) &&  (sum(Ind) ~= (q0+qa)) %% fixed additional components
            scores(i) = inf;
        end
         
     end