%
% ADI scheme for stochastic vol SPDE 
% 
function [D1X,D2X,D2X2,D1Y,D2Y,D2Y2,DXY,D1X_2,D2X_2,D2X2_2] = matrixcoef_stovol(hx,hy,Xmin,Xmax,Ymin,Ymax)

Jx = (Xmax-Xmin)/hx+1;
Jy = (Ymax-Ymin)/hy+1;

D1x_1 = repmat([-1 0 1],Jx,1);

D1x = spdiags(repmat([-1 0 1],Jx,1),[-1 0 1],Jx,Jx); 
D2x = spdiags(repmat([1 -2 1],Jx,1),[-1 0 1],Jx,Jx); 
D2x2= spdiags(repmat([1 -2 1],Jx,1),[-2 0 2],Jx,Jx); 
D1x([1,end],:)=0;  D2x([1,end],:)=0;
D2x2([1 2 end-1 end],:) = 0;
D2x2(2,[1 2 3]) = 2*[1 -2 1]; 
D2x2(end-1,end-[0 1 2]) = 2*[1 -2 1];

D1y_1=repmat([-1 0 1],Jy,1);
D1y = spdiags(repmat([-1 0 1],Jy,1),[-1 0 1],Jy,Jy); 
D2y = spdiags(repmat([1 -2 1],Jy,1),[-1 0 1],Jy,Jy); 
D2y2= spdiags(repmat([1 -2 1],Jy,1),[-2 0 2],Jy,Jy); 
D1y([1,end],:)=0;  D2y([1,end],:)=0;
D2y2([1 2 end-1 end],:) = 0;
D2y2(2,[1 2 3]) = 2*[1 -2 1]; D2y2(end-1,end-[0 1 2]) = 2*[1 -2 1];

% For ADI dim y, and explicit part:
% reshape to [U11,U21,...,Un1,U12,U22,...,Un2,...,U1m,U2m,...,Unm]
D1X_A=speye(Jy);
D1X = kron(D1x,speye(Jy)); % not tridiagonal
D2X = kron(D2x,speye(Jy));
D2X2 = kron(D2x2,speye(Jy));
D1Y = kron(speye(Jx),D1y); % tridiagonal
D2Y = kron(speye(Jx),D2y);
D2Y2 = kron(speye(Jx),D2y2);
DXY = circshift(D1X,[0 1]) - circshift(D1X,[0 -1]);

% Dirichlet b.c.
a = 1:Jy; 
b = ((Jx-1)*Jy+1):(Jx*Jy);
c = 1:Jy:(Jx*Jy);
d = Jy:Jy:(Jx*Jy);
D1X([a b c d],:) = 0;   D2X([a b c d],:) = 0;   D2X2([a b c d],:) = 0;
D1Y([a b c d],:) = 0;   D2Y([a b c d],:) = 0;   D2Y2([a b c d],:) = 0;
DXY([a b c d],:) = 0;

% For ADI dim x:
% reshape to [U11,U12,...,U1n,U21,U22,...,U2n,...,Um1,Um2,...,Umn]
D1X_2 = kron(speye(Jy),D1x); % tridiagonal
D2X_2 = kron(speye(Jy),D2x);
D2X2_2 = kron(speye(Jy),D2x2);

a2 = 1:Jx; 
b2 = ((Jy-1)*Jx+1):(Jy*Jx);
c2 = 1:Jx:(Jx*Jy);
d2 = Jx:Jx:(Jx*Jy);
D1X_2([a2 b2 c2 d2],:) = 0;    D2X_2([a2 b2 c2 d2],:) = 0;
D2X2_2([a2 b2 c2 d2],:) = 0;

end