%%
clear all;

tic
N = 200000;
n_max = 1600;
n = 400;
T = 2;
rhox=0.2;
rhoxy=0.45;
rhoy=0.2;
mu=0.0809;
kappa=0.2;
nu=0.5;
psi=0.1;
epsilon=0.4;

C = 4;

%Y0 = 1./exprnd(1, N, 1);
dW = randn(N, n_max+1)*sqrt(T/n_max);
W = cumsum(dW, 2);

dWvol = randn(N, n_max+1)*sqrt(T/n_max);
Wvol = cumsum(dWvol, 2);

Ws=zeros(N,n_max+1);
Wsvol=zeros(N,n_max+1);
dWs=randn(1,n_max+1)*sqrt(T/n_max);
dWsvol=randn(1,n_max+1)*sqrt(T/n_max);
dWsvol=rhoxy*dWs+sqrt(1-rhoxy^2)*dWsvol;
WS=cumsum(dWs,2);
WSVOL=cumsum(dWsvol,2);
for i=1:N
    Ws(i,:)=WS;
    Wsvol(i,:)=WSVOL;
end


    % generate U term - /sigma(y+U)
    ZZZ = zeros(1,n_max+1);
    scalar1 = exp(-kappa/epsilon*(T/n_max));
    scalar2 = nu*sqrt(2/epsilon*(T/n_max))*rhoy;

    % tic
    for i = 1:n_max
        ZZZ(i+1) = scalar1*(ZZZ(i) + scalar2*Wsvol(1,i)*sqrt(T/n_max));
    end
    % toc

    ZZZ = ZZZ(1:end); 
    U=zeros(N,n_max+1);
    for i=1:N
        U(i,:)=ZZZ;
    end


%Y0 = gamrnd(1.5, 0.5, [N, 1]);
Y0=ones(N,1)*2;
vol0=ones(N,1)*2;
prevx=Y0;
toc
figure;
tic
%%
narr = [50 100 200 400 800];
colorArr = {'Cyan', 'Black', 'Green', [0.7 0.7 0.7], 'Blue', 'Red', [0.2, 0.2, 0.2], [0.5, 0.5, 1]};
color = 0;
for n = narr
dt = T/n;
tt = linspace(0, T, n+1);

dn = n_max/n;
defaulted = false(N, 1);
alpha = 0.0;
Lam = 0;
Y = Y0;
vol=vol0;
defaulted = false(N, 1);
probs = ones(N, 1);
prevLam = 0;
prevY = Y0;
x = 1;
x1 = 1;
x2 = 1;
xx = zeros(n, 1);
isPlot = true;
WW = W(:, 1:dn:n_max+1);
WWvol = Wvol(:, 1:dn:n_max+1);
WWs=Ws(:, 1:dn:n_max+1);
WWsvol=Wsvol(:,1:dn:n_max+1);

for j = 1:n
    if mod(j, 100) == 0
        j;
    end    
    t = tt(j+1);
    dt = tt(j+1)-tt(j);
    dW = randn(N, 1);
    
    vol = vol0 - (kappa/epsilon)*vol*t + nu*sqrt(2*(1-rhoy^2)/epsilon)*WWsvol(:,j);
    sigma = exp(psi*vol);
    %sigma = 0.2;
    %Y = Y0 + sigma.*WW(:, j)*sqrt(1-rhox^2)+sigma.*WWs(:,j)*rhox - Lam + mu*t;
    Y = Y0 + sigma.*WW(:, j)*sqrt(1-rhox^2) + sigma.*WWs(:,j)*rhox - Lam + mu*t;
    %Y = Y0 + WW(:,j) - Lam;
    Y(defaulted) = 0;
    probs=probs.*(ones(N,1)-exp(-2*((prevx>=0).*(Y>=0))/dt));
    x=mean(ones(N,1)-probs);
    %x=mean(1-cumprod(1-exp(-(2*(prevx>=0).*(Y>=0)/dt))));
    prevx = x;
%     x = mean(Y <= 0);
    xx(j) = x;
    defaulted = defaulted | (Y <= 0);
    Y = Y + Lam;
    Lam = C*x;
    if sum(defaulted) == N
        debug = 1;
    end
    Y(defaulted) = 0;
%     if isPlot & (mod(j-1, 5) == 0)
%         figure;
%         hist(y(j, :), 50);
%     end
    if sum(defaulted) == N
        isPlot = false;
    end
end

[tt(end), xx(end)];
errN(n) = xx(end);
V=1-xx(end);
color = color + 1;
hold on;
plot(tt(1:end-1), xx, 'Color', colorArr{color});
xlabel('time'), ylabel('L_{t}')
% title(['MC Scheme N = ' num2str(N) ', n_{max} = ' num2str(n_max) ', n = ' num2str(n), ],'fontsize',10,'Interpreter','tex')
fprintf('MC n_max=%d,n=%d,N=%d,V=%8f\n',n_max,n,N,V)
end
toc
%%
tic
figure;

narr = [50 100 200 400 800];
colorArr = {'Cyan', 'Black', 'Green', [0.7 0.7 0.7], 'Blue', 'Red', [0.2, 0.2, 0.2], [0.5, 0.5, 1]};
color = 0;
for n = narr
dt = T/n;
tt = linspace(0, T, n+1);

dn = n_max/n;
defaulted = false(N, 1);
alpha = 0.0;
Lam = 0;
Y = Y0;
vol=vol0;
defaulted = false(N, 1);
probs = ones(N, 1);
prevLam = 0;
prevY = Y0;
x = 1;
x1 = 1;
x2 = 1;
xx = zeros(n, 1);
isPlot = true;
WW = W(:, 1:dn:n_max+1);
WWvol = Wvol(:, 1:dn:n_max+1);
WWs=Ws(:, 1:dn:n_max+1);
WWsvol=Wsvol(:,1:dn:n_max+1);
for j = 1:n
    if mod(j, 100) == 0
        j;
    end    
    t = tt(j+1);
    dt = tt(j+1)-tt(j);
    dW = randn(N, 1);
    
    vol = vol0 - (kappa/epsilon)*vol*t + nu*sqrt(2*(1-rhoy^2)/epsilon)*WWsvol(:,j);
    sigma = exp(psi*vol);
    %sigma = 0.2;
    %Y = Y0 + sigma.*WW(:, j)*sqrt(1-rhox^2)+sigma.*WWs(:,j)*rhox - Lam + mu*t;
    Y = Y0 + sigma.*WW(:, j)*sqrt(1-rhox^2) + sigma.*WWs(:,j)*rhox - Lam + mu*t;
    %Y = Y0 + WW(:,j) - Lam;
    Y(defaulted) = 0;
    %probs=probs.*(ones(N,1)-exp(-2*((prevx>=0).*(Y>=0))/dt));
    %x=mean(ones(N,1)-probs);
    %x=mean(1-cumprod(1-exp(-(2*(prevx>=0).*(Y>=0)/dt))));
    prevx = x;
    x = mean(Y <= 0);
    xx(j) = x;
    defaulted = defaulted | (Y <= 0);
    Y = Y + Lam;
    Lam = C*x;
    if sum(defaulted) == N
        debug = 1;
    end
    Y(defaulted) = 0;
%     if isPlot & (mod(j-1, 5) == 0)
%         figure;
%         hist(y(j, :), 50);
%     end
    if sum(defaulted) == N
        isPlot = false;
    end
end
            
[tt(end), xx(end)];
errN(n) = xx(end);
V=1-xx(end);
color = color + 1;
hold on;
plot(tt(1:end-1), xx, 'Color', colorArr{color});
xlabel('time'), ylabel('L_{t}')
% title(['MC Scheme N = ' num2str(N) ', n_{max} = ' num2str(n_max) ', n = ' num2str(n), ],'fontsize',10,'Interpreter','tex')
fprintf('MC n_max=%d,n=%d,N=%d,V=%8f\n',n_max,n,N,V)
end
toc

    