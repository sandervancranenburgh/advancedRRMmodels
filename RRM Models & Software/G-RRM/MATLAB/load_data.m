function [ncs, nalt, nat, vars, vars3d, delta_x, y, av, avrrm, panel, names] = load_data()
% This file loads the example data set
% The data contain RP shopping choices collected in 1997 in The Netherlands, see Arentze et al. (2005).

% Start a stopwatch timer to measure time required to load the data
tic;

% Number of choice situations
ncs = 1503;  

% Number of alternatives
nalt = 5;   

% Number of attributes
nat = 3;

% Load data. Make sure the path is correct.
xmat = dlmread('Shopping_data_with_headers.txt','\t',1,0);

% Columns of xmat that contain the explanatory variables
colx = [2:16];

% Identify column that contains the choices
coly = 17;

% Create an indicator matrix for the choices: ncs X nalt
y = (repmat(xmat(1:ncs,coly),[1 nalt]) == repmat(1:nalt,[ncs 1]));

% Create vars matrix: ncs*nalt X nat
vars = (reshape(xmat(:,colx)',[nat ncs*nalt])');

% Rescale variables (for numerical reasons) 
vars = vars.*(repmat([1/1000 1/1000 1/100],[ncs*nalt 1]));

% Permute xvars to make it 3D size: ncs x nalt x nat
vars3d = permute(reshape(vars',[nat nalt ncs]),[3 2 1]);

% Create indicator matrix for the avalability of alternatives: ncs X nalt  
av = ones(ncs,nalt);    % All alternatives are available for all observations

% Names of the taste parameters: Floorspace Groceries, Floorspace Other, Travel Time.
names = {'B_FSG' 'B_FSO' 'B_TT '};

%% LC models only
% Create a NCS x NALT^2 x NAT Matrix containing the attribute differences
% associated with each pairwise comparison. Doing so avoids the need to use for 
% loops in the loglik function, making the estimation of RRM models much faster. 
delta_x = zeros(ncs,nalt^2,nat);
for n = 1:ncs
    for i = 1:nalt
        if av(n,i) == 1
            for j = 1:nalt
                if av(n,j) == 1 && i ~= j
                    delta_x(n,(i-1)*nalt+j,:) = (vars3d(n,j,:) - vars3d(n,i,:));
                end
            end
        end
    end
end

% Create availability matrix on the level of the pairwise comparisons. This
% matrix is used in combination with delta_x
avrrm = ones(nalt);
avrrm(logical(eye(size(avrrm)))) = 0;
avrrm = repmat(avrrm(:)',[ncs 1]);
avrrm = repmat(reshape(permute(repmat([av],[1 1 nalt]),[3 2 1]),[nalt^2 ncs])'.*avrrm,[1 1 nat]);

% Panel structure of the data
[~,T]=count_unique(xmat(:,1));
TT = [0;T(1:end-1)];
panel = [cumsum(TT)+1 cumsum(TT)+T];

% Display time requires to load the data
disp(['Data loaded in ' num2str(toc) ' seconds.']); 

end
