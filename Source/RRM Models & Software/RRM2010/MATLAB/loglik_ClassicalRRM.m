function [ ll ] = loglik_ClassicalRRM(coef)
% This function computes the log-likelihood of the Classical RRM-MNL model

% Set global variables
global NCS NALT NAT AV Y VARS3D

% Permute parameters
coef = permute(coef,[3 2 1]);

% Compute observed regret i.e. sum all regrets of all pairwise comparisons
r = zeros(NCS,NALT,NAT);
for n = 1:NCS
    for i = 1:NALT
        if AV(n,i) == 1
            for j = 1:NALT
                if AV(n,j) == 1 && i ~= j
                    r(n,i,:) = r(n,i,:) + log(1 + exp( coef.*(VARS3D(n,j,:) - VARS3D(n,i,:))));
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

