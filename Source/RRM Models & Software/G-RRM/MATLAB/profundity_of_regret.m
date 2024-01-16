function [alpha_m] = profundity_of_regret(paramhat)

global NCS NAT NALT AV VARS3D

coef = paramhat(1:NAT);

if length(paramhat) == NAT
    mu = 1;
else
    mu = paramhat(end);
end


A = zeros(1,NAT);
alp = zeros(1,NAT);
for m = 1:NAT
    for n = 1:NCS
        for i = 1:NALT
            for j = 1:NALT 
                if AV(n,i) == 1 && AV(n,j) == 1 && i ~= j && VARS3D(n,j,m) ~= VARS3D(n,i,m)
                    A(1,m) = A(1,m) + 1;
                    alp(1,m) = alp(1,m) + abs((exp((coef(m)/mu)*(VARS3D(n,j,m) - VARS3D(n,i,m))) -1 )/(exp((coef(m)/mu)*(VARS3D(n,j,m) - VARS3D(n,i,m))) +1 ));
                end
            end
        end
    end
end
alpha_m = alp./A;
                    















% Alpha_m = -99*ones(1,NAT + sum(I_RRMVAR,2));
% 
% 
% if length(mu) >=2
%     for n=1:NAT
%         dx = deltax(:,n);
%         dx = dx(dx>0);
%         Alpha_m(1,n)=sum(abs((exp((paramhat(n)/mu(n)).*dx)-1)./(exp((paramhat(n)/mu(n)).*dx)+1)))/length(dx);
%     end
% 
% elseif length(mu) == 1
% 
%     for n=1:NAT
%         dx = deltax(:,n);
%         dx = dx(dx>0);
%         Alpha_m(1,n)=sum(abs((exp((paramhat(n)/mu).*dx)-1)./(exp((paramhat(n)/mu).*dx)+1)))/length(dx);
%     end              
% end
% 
% 
% Alpha_m(RRMVAR~=1)=-99;
