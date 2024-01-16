function [ paramhat ] = estimate(model,startingvalues,names)
% This file starts the maximum likelihood estimation

global NCS AV NOC SETS LC

%Start timer 1
t1 = clock;

% Set options for the optimization algorithm
options = optimset('LargeScale','off','Display','off','GradObj','off',...
    'MaxFunEvals',10000,'MaxIter',1000,'TolX',1e-7,'TolFun',1e-6,'DerivativeCheck','off');

% Assign the loglikelihood function associated with the the model
if     model == 1 % Linear-additive RUM-MNL
    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_RUM,startingvalues',options);

elseif model == 2 % P-RRM-MNL
    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_PRRM,startingvalues',options);

elseif model == 3 % muRRM-MNL
    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_muRRM,startingvalues',options);
     paramhat(end) = abs(paramhat(end)); % Since in the muRRM model the absolute value of mu is used (to avoid flipping of all signs)
     
elseif model == 4 % Classical RRM-MNL
    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_ClassicalRRM,startingvalues',options);

elseif model == 5 % G-RRM-MNL
    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_GRRM,startingvalues',options);
toc;

elseif model > 5
       for m = 1:SETS
            tic;
            disp(' ')
            disp(['Startingvalues set ',num2str(m)]);
            if model == 6 % LC RUM PRRM model (two classes)
                % Check if Objective function is undefined at initial point
                if isnan(loglik_LC_2_RUM_PRRM(startingvalues(m,:)'))~= 1    
                    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_LC_2_RUM_PRRM,startingvalues(m,:)',options);
                    disp(' ')
                    disp(sprintf('%s %0.1f %s', '     Estimation took ', toc, ' seconds.'));
                    disp(['     EXITFLAG = ' num2str(exitflag)]);
                    if exitflag == 1
                        disp(' ')
                        disp(['     Null LL : ' num2str(-sum(log(sum(AV,2))))]);
                        disp(['     Final LL: ' num2str(-fval)]);
                        disp(['     rho_sq  :  ' num2str(1-(-fval/-sum(log(sum(AV,2)))))]);
                    else
                        disp('     No convergence reached')
                    end
                    LC(m).paramhat = paramhat;
                    LC(m).fval = fval;
                    LC(m).exitflag = exitflag;
                    LC(m).hessian = hessian;
                else
                    LC(m).fval = -1e6;
                    LC(m).exitflag =5;
                end
                
            elseif model ==7
                % Check if Objective function is undefined at initial point
                if (isnan(loglik_LC_2_muRRM(startingvalues(m,:)')) + (isinf(loglik_LC_2_muRRM(startingvalues(m,:)'))))== 0    
                   [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_LC_2_muRRM,startingvalues(m,:)',options);
                    disp(' ')
                    disp(sprintf('%s %0.1f %s', '     Estimation took ', toc, ' seconds.'));
                    disp(['     EXITFLAG = ' num2str(exitflag)]);
                    if exitflag == 1
                        disp(' ')
                        disp(['     Null LL : ' num2str(-sum(log(sum(AV,2))))]);
                        disp(['     Final LL: ' num2str(-fval)]);
                        disp(['     rho_sq  :  ' num2str(1-(-fval/-sum(log(sum(AV,2)))))]);
                    else
                        disp('     No convergence reached')
                    end
                    LC(m).paramhat = paramhat;
                    LC(m).fval = fval;
                    LC(m).exitflag = exitflag;
                    LC(m).hessian = hessian;
                else
                    LC(m).fval = 1e6;
                    LC(m).exitflag =5;
                end
                
            elseif model == 8 % LC RUM muRRM PRRM (three classes)
                % Check if Objective function is undefined at initial point
                if (isnan(loglik_LC_3_RUM_muRRM_PRRM(startingvalues(m,:)')) + (isinf(loglik_LC_3_RUM_muRRM_PRRM(startingvalues(m,:)')))) == 0 
                    [paramhat,fval,exitflag,~,~,hessian] = fminunc(@loglik_LC_3_RUM_muRRM_PRRM,startingvalues(m,:)',options);
                    disp(' ')
                    disp(sprintf('%s %0.1f %s', '     Estimation took ', toc, ' seconds.'));
                    disp(['     EXITFLAG = ' num2str(exitflag)]);
                    if exitflag == 1
                        disp(' ')
                        disp(['     Null LL : ' num2str(-sum(log(sum(AV,2))))]);
                        disp(['     Final LL: ' num2str(-fval)]);
                        disp(['     rho_sq  :  ' num2str(1-(-fval/-sum(log(sum(AV,2)))))]);
                    else
                        disp('     No convergence reached')
                    end
                    LC(m).paramhat = paramhat;
                    LC(m).fval = fval;
                    LC(m).exitflag = exitflag;
                    LC(m).hessian = hessian;
                else
                    LC(m).fval = 1e6;
                    LC(m).exitflag =5;
                end
            end
        end
end

% Report best model (LC models only)
if model > 5 
    [~,I] = max(-[LC(:).fval] - 1e6.*([LC(:).exitflag]~=1));
    paramhat = LC(I).paramhat;
    fval = LC(I).fval;
    exitflag = LC(I).exitflag;
    hessian = LC(I).hessian;
end


% Display estimation diagnostics
t2 = clock;
disp(' ')
disp(' ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ')
disp(' ')
disp(sprintf('%s %0.1f %s', 'Estimation took ', etime(t2,t1), ' seconds.'));
if model > 5
    disp(['Best model obtained using startingvalues set ', num2str(I)])
end
disp(['EXITFLAG = ' num2str(exitflag)]);
disp(' ')
disp(['Null LL : ' num2str(-sum(log(sum(AV,2))))]);
disp(['Final LL: ' num2str(-fval)]);
disp(['rho_sq  :  ' num2str(1-(-fval/-sum(log(sum(AV,2)))))]);

% Take inverse of the hessian
ihess = inv(hessian);
stderr = sqrt(diag(ihess));

% Since in the G-RRM model a logistic transformation is used to ensure gamma is in between 0 and 1, this parameter needs to be transposed back. 
if model == 5
    paramhat(end) = exp(paramhat(end))/(1+exp(paramhat(end)));
    stderr(end)   = exp(stderr(end))  /(1+exp(stderr(end)));
end

% Compute t-values and p-values
tval = paramhat./stderr;
pval = (1-tcdf(abs(tval),NCS-1))*2;

% Display results
disp(' ');
disp('                             ESTIMATION RESULTS');
disp('                 -----------------------------------------');
disp('                  Est         SE         t-stat       p-val');

for r=1:size(names,2);
    fprintf('%-10s\t %10.4f\t %10.4f\t %10.2f\t %10.2f\n', names{1,r}, [paramhat(r,1) stderr(r,1) tval(r,1) pval(r,1)]);
end

disp(' ')
disp(' ')

% Report class probablilities
if model > 5 
    denum = sum(exp([0;paramhat(end-NOC+2:end)]));
    p_class1 = exp(0)./denum;

    disp(' ');
    disp('           Class probabilities');
    disp('           -------------------');

    fprintf('%-10s\t %10.2f\n', 'Class_1', p_class1);

    for r = 2:NOC;
        p_class = exp(paramhat(end-NOC+r))/denum;
        fprintf('%-10s\t %10.2f\n', ['Class_', num2str(r)], p_class);
    end

disp(' ')
disp(' ')
end
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ')

