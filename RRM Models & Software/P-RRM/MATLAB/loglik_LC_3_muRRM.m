function [ ll ] = loglik_LC_3_muRRM(coef)
% This function computes the log-likelihood of a 2 class latent muRRM-MNL model

% Set global variables
global NCS NALT NAT AV AVRRM Y DELTA_X PANEL

%% Get parameters
coef_s1 = permute(coef(1:NAT),[3 2 1]);
coef_s2 = permute(coef(NAT+1:2*NAT),[3 2 1]);
mu_s1 = abs(coef(2*NAT+1));
mu_s2 = abs(coef(2*NAT+2));
s1 = 0;
s2 = coef(2*NAT+3);

%% Compute observed regret i.e. sum all regrets of all pairwise comparisons

% Class 1
% r_s1 = exp(mu_s1).* AVRRM.*(log(1 + exp(repmat(coef_s1,[NCS,NALT^2,1]).*DELTA_X)));
r_s1 = mu_s1 .* AVRRM.*(log(1 + exp(repmat(coef_s1./mu_s1,[NCS,NALT^2,1]).*DELTA_X)));
r_s1 = reshape(permute(r_s1,[2 1 3]),[NALT,NCS*NALT,NAT]);
r_s1 = sum(sum(r_s1,1),3);
r_s1(r_s1>700) =  700;  % To avoid numerical overflow
r_s1(r_s1<-700)= -700;  % To avoid numerical overflow

% Class 2
% r_s2 = exp(mu_s2).* AVRRM.*(log(1 + exp(repmat(coef_s2,[NCS,NALT^2,1]).*DELTA_X)));
r_s2 = mu_s2 .* AVRRM.*(log(1 + exp(repmat(coef_s2./mu_s2,[NCS,NALT^2,1]).*DELTA_X)));
r_s2 = reshape(permute(r_s2,[2 1 3]),[NALT,NCS*NALT,NAT]);
r_s2 = sum(sum(r_s2,1),3);
r_s2(r_s2>700) =  700;  % To avoid numerical overflow
r_s2(r_s2<-700)= -700;  % To avoid numerical overflow

%% Take exponent of the NEGATIVE of the observed overall regrets
er_s1 = exp(-(reshape((r_s1),[NALT NCS])'));
er_s2 = exp(-(reshape((r_s2),[NALT NCS])'));

%% Compute the conditional probabilities of observing the choice given the set of parameters
p_s1  = sum(Y.*er_s1,2)./sum(AV.*er_s1,2);
p_s2  = sum(Y.*er_s2,2)./sum(AV.*er_s2,2);

%% Panel probabilities
p_s1_seq = zeros(length(PANEL),1);
p_s2_seq = zeros(length(PANEL),1);
for n = 1:length(PANEL)
    p_s1_seq(n) = prod(p_s1(PANEL(n,1):PANEL(n,2)));
    p_s2_seq(n) = prod(p_s2(PANEL(n,1):PANEL(n,2)));
end
    
%% Compute class probabilities
ps1 = exp(s1)/(exp(s1)+exp(s2));
ps2 = exp(s2)/(exp(s1)+exp(s2));

%% Probabilities
P_LC = ps1*p_s1_seq + ps2*p_s2_seq;

%% Compute the log-likelihood
ll=-sum(log(P_LC));  %Negative since neg of ll is minimized
