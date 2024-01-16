function [ ll ] = loglik_LC_2_RUM_PRRM(coef)
% This function computes the log-likelihood of a LC RUM-P-RRM model (two
% classes)

% Set global variables
global NCS NALT NAT AV Y VARS DELTA_X AVRRM PANEL

%% Get parameters
coef_s1 = coef(1:NAT);
coef_s2 = permute(coef(NAT+1:2*NAT)  ,[3 2 1]);

% Class coefficients
s1 = 0;
s2 = coef(2*NAT+1);

%% Compute observed utilities and regrets for each class
% RUM CLASS
v_s1 = VARS*coef_s1;
v_s1(v_s1>700) =  700; % To avoid numerical overflow
v_s1(v_s1<-700)= -700; % To avoid numerical overflow

% PRRM CLASS
r_s2 = AVRRM.*max(0,repmat(coef_s2,[NCS,NALT^2,1]).*DELTA_X);
r_s2 = reshape(permute(r_s2,[2 1 3]),[NALT,NCS*NALT,NAT]);
r_s2 = sum(sum(r_s2,1),3);
r_s2(r_s2>700) =  700;  % To avoid numerical overflow
r_s2(r_s2<-700)= -700;  % To avoid numerical overflow

%% Take exponent of the observed utilities / regrets
ev_s1 = reshape(exp(v_s1),NALT,NCS)'; 
er_s2 = exp(-(reshape((r_s2),[NALT NCS])'));

%% Compute the probability of observing each choice given the set of parameters
p_s1  = sum(Y.*ev_s1,2)./sum(AV.*ev_s1,2);
p_s2  = sum(Y.*er_s2,2)./sum(AV.*er_s2,2);

%% Panel probabilities
p_s1_seq = zeros(length(PANEL),1);
p_s2_seq = zeros(length(PANEL),1);
for n = 1:length(PANEL)
    p_s1_seq(n) = prod(p_s1(PANEL(n,1):PANEL(n,2)));
    p_s2_seq(n) = prod(p_s2(PANEL(n,1):PANEL(n,2)));
end

%% Class probabilities
ps1 = exp(s1)/(exp(s1)+ exp(s2));
ps2 = exp(s2)/(exp(s1)+ exp(s2));

%% Conditional probabilities
P_LC = ps1.*p_s1_seq + ps2.*p_s2_seq;

%% Compute the log-likelihood
ll=-sum(log(P_LC));  %Negative since neg of ll is minimized


