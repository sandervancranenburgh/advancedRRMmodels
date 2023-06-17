function [ ll ] = loglik_muRRM(coef)
% This function computes the log-likelihood of the muRRM-MNL model

% Set global variables
global NCS NALT NAT AV Y VARS3D

% Get parameters
mu = abs(coef(end));
coef = permute(coef(1:end-1),[3 2 1]);

% Compute observed regret i.e. sum all regrets of all pairwise comparisons
r = zeros(NCS,NALT,NAT);
for n = 1:NCS
    for i = 1:NALT
        if AV(n,i) == 1
            for j = 1:NALT
                if AV(n,j) == 1 && i ~= j
                    r(n,i,:) = r(n,i,:) + mu * log(1 + exp( (coef./mu).*(VARS3D(n,j,:) - VARS3D(n,i,:))));
                end
            end
        end
    end
end

% Take the sum over all attributes to get the observed overall regrets
r = sum(r,3);

% Take exponent of the NEGATIVE of the observed overall regrets
er = exp(-r);

% Compute the probability of observing each choice given the set of parameters
p  = sum(Y.*er,2)./sum(AV.*er,2);

% Compute the log-likelihood
ll = -sum(log(p));  

