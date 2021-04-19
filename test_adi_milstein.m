clear all;       
% lx=6;
% ly=6;
lt=4;
X0=2;
Y0=2;
rhox=0.20;
rhoxy=0.45;
epsilon=0.4;
psi=0.1;
mu = 0.0809;
nu=0.5;
shape=0.5;
scale=1.5;
M=100;
T=1.2;

k0 = 0.25;
k = k0*4^-lt;
N = round(T/k);
time=linspace(0,T,N);
alpha=4.0*0.7;  %turn off if varying
lx=4; ly=4; %turn off if varying

%% for error
% narr=[1 2 3 4 5 6];
% VS=[];
% Vs=zeros(1,numel(narr));
% 
% tic
% parfor k = 1:M
% VS=[];
%     randn('state',0)
%     Zx = randn(1,N);   ZY = randn(1,N);
%     Zy = rhoxy*Zx + sqrt(1-rhoxy^2)*ZY;
% 
%     for l=narr
%         lx=l;
%         ly=l;
%         [V,lossline,time] = SinglePath_MC_Err(lx,ly,lt,epsilon,alpha,psi,mu,X0,Y0,nu,rhox,Zx,Zy);
%         VS(end+1)=V;
%     end
% 
%     Vs=Vs+VS;
% %     VS=[];
% end
% toc
% 
% Vs=Vs/M;
% 
% for m = 1:numel(Vs)
%     fprintf('lx=%d,ly=%d,lt=%d,M = %d,V=%8f\n',narr(m),narr(m),lt,M,Vs(m))
% end

%% for loss line
narr=[0.1 0.2 0.3 0.4];
VS=[];
Vs=zeros(1,numel(narr));
Ls=zeros(numel(narr),N);

tic
parfor k = 1:M
VS=[];
LS=[];
    %randn('state',0)
    Zx = randn(1,N);   ZY = randn(1,N);
    Zy = rhoxy*Zx + sqrt(1-rhoxy^2)*ZY;

    for rhox=narr
        [V,lossline,time] = adi_milstein(lx,ly,lt,epsilon,alpha,psi,mu,X0,Y0,nu,rhox,Zx,Zy);
        VS(end+1)=V;
        LS(end+1,:)=lossline(1,:);
    end

    Vs=Vs+VS;
    Ls=Ls+LS;
end
toc

Vs=Vs/M;
Ls=Ls/M;

for m = 1:numel(Vs)
    fprintf('lx=%d,ly=%d,lt=%d,alpha=%d, M = %d,V=%8f\n',lx,ly,lt,narr(m),M,Vs(m))
end

colorArr = {'Black', 'Blue', 'Cyan', [0.7 0.7 0.7], 'Green', 'Red', [0.2, 0.2, 0.2], [0.5, 0.5, 1]};
color = 0;

figure;
count=height(Ls);

for i=1:height(Ls)
    color = color + 1;
    hold on;
    plot(time, Ls(i,:), 'Color', colorArr{color}, 'linewidth',1.0);
    xlabel('time','Interpreter','latex','fontsize',12), ylabel('$L_{t}$','Interpreter','latex','fontsize',12)
end
h = legend('$\rho_{x}$=0.1','$\rho_{x}$=0.2','$\rho_{x}$=0.3','$\rho_{x}$=0.4','$\rho_{x}$=0.5');
set(h,'Interpreter','latex','FontSize',12,'location','southwest')

%% for error over time
% narr=[4 5];
% VS=[];
% Vs=zeros(1,numel(narr));
% Ls=zeros(numel(narr),N);
% 
% tic
% parfor k = 1:M
% VS=[];
% LS=[];
%     randn('state',0)
%     Zx = randn(1,N);   ZY = randn(1,N);
%     Zy = rhoxy*Zx + sqrt(1-rhoxy^2)*ZY;
% 
%     for l=narr
%         lx=l;
%         ly=l;
%         [V,lossline,time] = SinglePath_MC_Err(lx,ly,lt,epsilon,alpha,psi,mu,X0,Y0,nu,rhoxy,Zx,Zy);
%         VS(end+1)=V;
%         LS(end+1,:)=lossline(1,:);
%     end
% 
%     Vs=Vs+VS;
%     Ls=Ls+LS;
% %     VS=[];
% end
% toc
% 
% Vs=Vs/M;
% Ls=Ls/M;
% 
% figure;
% colorArr = {'Blue', 'Cyan', 'Black', [0.7 0.7 0.7], 'Green', 'Red', [0.2, 0.2, 0.2], [0.5, 0.5, 1]};
% color = 0;
% 
% for i=1:(height(Ls)-1)
%     Lerr(i,:)=Ls(i,:)-Ls(i+1,:);
%     color = color + 1;
%     hold on;
%     plot(time, Lerr(i,:), 'Color', colorArr{color}, 'linewidth',1.5);
%     xlabel('time','Interpreter','latex','fontsize',12), ylabel('$|\tilde{V}_{T}^{2m}-\tilde{V}_{T}^{m}|$','Interpreter','latex','fontsize',12)
% end
% h = legend('$|\tilde{V}_{t}^{321}-\tilde{V}_{t}^{161}|');
% set(h,'Interpreter','latex','FontSize',12,'location','southwest');
% 
% figure;
% color = 0;
% 
% for i=1:height(Ls)
%     color = color + 1;
%     hold on;
%     plot(time, Ls(i,:), 'Color', colorArr{color}, 'linewidth',1.5);
%     xlabel('time','Interpreter','latex','fontsize',12), ylabel('$L_{t}$','Interpreter','latex','fontsize',12)
% end
% h = legend('$L_{t}^{m=161}$','$L_{t}^{m=321}$');
% set(h,'Interpreter','latex','FontSize',12,'location','southwest')
% axis([0 1 0 1]);