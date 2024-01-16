function [ prrm_xvars ] = prrm_matrix( signbeta, av, vars_in )
% This function generates the P-RRM X matrix from the matrix containing the explanatory variables.
% signbeta  1 X NAT           indicator vector (-1, or 1), indicating whether a the taste parameters are expected to be positive of negative.
% av        NCS X NALT        indicator matrix ( 0, or 1), indicating whether or not an alternative is available.
% vars_in   NCS X NALT X NAT  , or other sizes: NCS*NALT X NAT, or NCS X NALT*NAT. This matrix contains the explanatory variables.

% Set the global variables 
global NCS NALT NAT

% Start a stopwatch timer to measure time required to create the PRRM X matrix
tic;

% Check size of "vars_in", and reshape it such that obtains the size NCS X NALT X NAT
if size(vars_in,1) == NCS && size(vars_in,2) == NALT && size(vars_in,3) == NAT
    vars3d = vars_in;
elseif size(vars_in,1) == NCS * NALT && size(vars_in,2) == NAT
    vars3d = permute(reshape(vars_in',[NAT NALT NCS]),[3 2 1]);
elseif size(vars_in,1) == NCS && size(vars_in,2) == NALT * NAT
    vars3d = permute(reshape(vars_in',[NAT NALT NCS]),[3 2 1]);
end

% Compute the PRRM X matrix
prrm_xvars = zeros(NCS,NALT,NAT);
nrnat = 1:NAT;
pos = nrnat(signbeta ==  1); % Indicator vector for positive taste parameter
neg = nrnat(signbeta == -1); % Indicator vector for negative taste parameter

for n=1:NCS
    for i = 1:NALT
        if av(n,i) == 1
            for j = 1:NALT
                if av(n,j) == 1 && i ~= j
                    prrm_xvars(n,i,pos) = prrm_xvars(n,i,pos) + max(0,vars3d(n,j,pos) - vars3d(n,i,pos));
                    prrm_xvars(n,i,neg) = prrm_xvars(n,i,neg) + min(0,vars3d(n,j,neg) - vars3d(n,i,neg));
                end
            end
        end
    end
end

% Display time requires to create the PRRM X matrix
disp(['PRRM matrix created in ' num2str(toc) ' seconds.']); 
                
end