%
% initial density for dirac function 2 dim with sto vol
% 

function [X,Y,uu] = initial_stovol(Xmin,Xmax,Ymin,Ymax,h1,h2,X0,Y0)

[x,fx] = Initial(Xmin,Xmax,h1,X0);
[y,fy] = Initial(Ymin,Ymax,h2,Y0);
[xx,yy] = meshgrid(fx,fy); 
[X,Y] = meshgrid(x,y); 
uu = (xx.*yy);

end