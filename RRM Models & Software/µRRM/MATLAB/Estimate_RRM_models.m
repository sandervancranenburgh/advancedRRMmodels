 % This m-file:
% 1 ) Estimates a Linear-additive RUM-MNL model
% 2 ) Estimates a P-RRM-MNL model, See Van Cranenburgh et al. (2015)
% 3A) Estimates a muRRM-MNL model (with one generic scale parameter gamma), See Van Cranenburgh et al. (2015)
% 3B) Conduct ex post analysis on the profundity of regret imposed by the muRRM model, See Van Cranenburgh et al. (2015)
% 4A ) Estimate a Classical RRM model, See Chorus (2010)
% 4B) Conduct ex post analysis on the profundity of regret imposed by the Classical RRM model, See Van Cranenburgh et al. (2015)
% 5 ) Estimates a G-RRM model (with one generic weighting parameter gamma), See Chorus (2014)
% 6 ) Estimates a latent class muRRM model (with two classes)

% Written by Sander van Cranenburgh, 23 december 2014 

% Clear the workspace
clear global;
clear;
close all;
clc;
rng(1);

% Set the global variables
global NCS NALT NAT
global Y AV
global VARS PRRM_VARS VARS3D

% This function loads the data
[NCS, NALT, NAT, VARS, VARS3D, ~, Y, AV, ~, ~,names] = load_data();

% Indicate whether the taste parameters are expected to be positive or negative
% positive =  1
% negative = -1
signbeta = [1 1 -1];

% This function create PRRM matrix
[ PRRM_VARS ] = prrm_matrix( signbeta, AV, VARS);


%% 1) Estimate Linear-additive RUM-MNL model
    disp(' ')
    disp(' ')
    disp('1) Start estimation of RUM MNL model')

    % Starting values
    b0=zeros(1,NAT);

    % Start estimation
    [ paramhat_rum ] = estimate(1,b0,names);
   
    

%% 2) Estimate P-RRM-MNL model
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('2) Start estimation of PRRM-MNL model')

    % Starting values
    b0=zeros(1,NAT);

    % Start estimation
    [ paramhat_prrm ] = estimate(2,b0,names);

    
    
%% 3A) Estimate muRRM-MNL model
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('3A) Start estimation of muRRM-MNL model')

    % Starting values
    b0=[zeros(1,NAT) 1];

    % Start estimation
    [ paramhat_murrm ] = estimate(3,b0,[names 'mu   ']);

  
 
%% 3B) Conduct ex post analysis on the profundity of regret imposed by the muRRM model
    disp(' ')
    disp(' ')
    disp('3B) Ex post analysis on profundity of regret')
    
    % Compute profundity of regret for each attribute
    % Note that it is only sensible to compute profundity of regret for non-binary attributes (such as dummies and ASCs).
    [ alpha_m ] = profundity_of_regret(paramhat_murrm);
    
    % Display results
    disp(' ')
    for m = 1:NAT
        fprintf('%-10s\t %10.2f\n',[ 'alpha_' names{1,m} ':'], alpha_m(m))
    end
   


%% 4) Estimate Classic RRM-MNL model
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('4) Start estimation of Classical RRM-MNL model')

    % Starting values
    b0 = zeros(1,NAT);

    % Start estimation
    [ paramhat_classicalrrm ] = estimate(4,b0,names);
    


    
%% 4B) Conduct ex post analysis on the profundity of regret imposed by the Classical RRM model
    disp(' ')
    disp(' ')
    disp('4B) Ex post analysis on profundity of regret')
    
    % Compute profundity of regret for each attribute. 
    % Note that it is only sensible to compute profundity of regret for non-binary attributes (such as dummies and ASCs).
    [ alpha_m ] = profundity_of_regret(paramhat_classicalrrm);
    
    % Display results
    disp(' ')
    for m = 1:NAT
        fprintf('%-10s\t %10.2f\n',[ 'alpha_' names{1,m} ':'], alpha_m(m))
    end



%% 5) Estimate G-RRM-MNL model
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('5) Start estimation of G-RRM-MNL model')

    % Starting values
    b0=[zeros(1,NAT) 1];

    % Start estimation
    [ paramhat_GRRM ] = estimate(5,b0,[names 'gamma ']);


