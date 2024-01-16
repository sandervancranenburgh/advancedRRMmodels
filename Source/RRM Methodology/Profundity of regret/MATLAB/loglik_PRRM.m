function [ ll ] = loglik_PRRM(coef)
% This function computes the log-likelihood of the PRRM-MNL model

% Set global variables
global NCS NALT AV Y PRRM_VARS

% Compute the observed overall regrets
r = sum(repmat(permute(coef,[2 3 1]),[NCS,NALT,1]).* PRRM_VARS,3);

% Take exponent of the NEGATIVE of the observed overall regrets
er = exp(-r);

% Compute the probability of observing each choice given the set of parameters
p  = sum(Y.*er,2)./sum(AV.*er,2);

% Compute the log-likelihood
ll = -sum(log(p));  
