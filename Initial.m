%
% initial density for dirac function
% 

function [X,IniDensity] = Initial(Xmin,Xmax,h,X0)

J = (Xmax-Xmin)/h;
X = linspace(Xmin,Xmax,J+1)';
IniDensity = zeros(size(X));

pos = (X0-Xmin)/h+1; 
ind = floor(pos);   % suppose X0 \in (x_j-1,x_j), then ind returns index of x_j-1
IniDensity(ind) = 1-(X0-X(ind))/h;
IniDensity(ind+1) = 1-(X(ind+1)-X0)/h;

IniDensity = IniDensity/h;

end