function [ ll ] = loglik_RUM(coef)
% This function compute the log-likelihood of the RUM-MNL model

% Set global variables
global NCS NALT VARS AV Y

% Compute observed utility
v = VARS*coef;

% Take the exponent of the observed utility, and reshape
ev = (AV'.*reshape(exp(v),NALT,NCS))';   

% Compute the probability of observing each choice given the set of parameters
p = sum(Y.*ev,2)./sum(ev,2);

% Compute the log-likelihood
ll = -sum(log(p)); 