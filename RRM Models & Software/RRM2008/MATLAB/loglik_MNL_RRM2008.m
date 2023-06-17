function [ ll ] = loglik_MNL_RRM2008(coef)
% This function computes the log-likelihood of the RRM2008-MNL model

% Set global variables
global NCS NALT NAT AV Y VARS3D VARS




for alt_i = 1:NALT
    for alt_j = 1:NALT

        % Make comparison if i unequal to j
        if alt_i ~= alt_j

            % Compare i with j, for all attributes, and sum
            r_ij = zeros(NCS,1);
            for k = 1:NAT
                r_ij = r_ij + max(0,(coef(k).*(VARS3D(:,alt_j,k)-VARS3D(:,alt_i,k))));
            end
            
            % Collect regret
            r(:,alt_i,alt_j) = r_ij;
        end
    end
end


% Take the max of the regrets.
r = max(r,[],3);
% r = sum(r,3);

% Take exponent of the NEGATIVE of the observed overall regrets
er = exp(-r);

% Compute the probability of observing each choice given the set of parameters
p  = sum(Y.*er,2)./sum(AV(:,:,1).*er,2);

% Compute the log-likelihood
ll = -sum(log(p));  

