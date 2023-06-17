% This m-file:
% 1 ) Latent class RUM-PRRM model (two classes)
% 2 ) Estimates a latent class muRRM model (with two classes)
% 3)  Latent Class RUM-muRRM-PRRM model (three classes)

% Written by Sander van Cranenburgh, 28 October 2015 

% Clear the workspace
clear global;
clear;
close all;
clc;

% Set the global variables
global NCS NALT NAT NOC SETS
global Y AV AVRRM PANEL
global VARS DELTA_X

% Set the seeds
rng(1);

% LC models get often stuck in local minima. Therefore, it is necessary to
% use a series of different starting values 
% Number of starting value sets
SETS = 25;

% This function loads the data
[NCS, NALT, NAT, VARS, ~, DELTA_X, Y, AV, AVRRM, PANEL, names] = load_data();

%% 1) Estimate Latent class RUM-PRRM model (2 classes)
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('1) Start estimation of Latent Class RUM-PRRM model (two classes)')
    NOC = 2;
   
    for n = 1:NOC
        for m = 1:NAT
            lc_names{m,n} = [names{m} '_' num2str(n)];
        end
    end
    lc_names = [lc_names(:)' 's2'];
    
    % Starting values
    b0 = [rand(SETS,length(lc_names))];
    
    % Start estimation
    [ paramhat_2rum_prrm ] = estimate(6,b0,lc_names);
    


%% 2) Estimate Latent class muRRM-MNL model (two classes)
    clearvars lc_names
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('2) Start estimation of Latent Class muRRM model (two classes)')
    NOC = 2;
    
    % Starting values
    for n = 1:NOC
        for m = 1:NAT
            lc_names{m,n} = [names{m} '_' num2str(n)];
        end
    end
    lc_names = [lc_names(:)' 'mu1' 'mu2' 's2'];
    
    % Starting values
    b0 = [rand(SETS,length(lc_names))];
        
    % Start estimation
    [ paramhat_2classmurrm ] = estimate(7,b0,lc_names);

   
    
%% 3) Estimate Latent class RUM-muRRM-PRRM model (three classes)
    clearvars lc_names    
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp('3) Start estimation of Latent Class RUM-muRRM-PRRM model (three classes)')
    NOC = 3;
   
    for n = 1:NOC
        for m = 1:NAT
            lc_names{m,n} = [names{m} '_' num2str(n)];
        end
    end
    lc_names = [lc_names(:)' 'mu' 's2' 's3'];

    % Starting values
    b0 = [rand(SETS,length(lc_names))];
    
    % Start estimation
    [ paramhat_3class ] = estimate(8,b0,lc_names);


