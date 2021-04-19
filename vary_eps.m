% This script tests the function impliedVol(Cm, S, K, r, tau).
%
% Steps:
%       1. Specify input parameters for callPrice function
%       2. Compute Black-Scholes call prices (Cbs)
%       3. Add a fixed premium of $0.25 to call prices (Cbs)
%       4. Use obtained prices to derive implied volatility
%       3. Plot implied volatility as a function of strike (K)
%       4. Plot original volatility as a function of strike(K)

clear all;
%S=61.32;
%03655
%03447

% pvbp
% fep
% spread

% KCollection1=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
KCollection1=linspace(log(0.75)/0.4,log(1.25)/0.4,30);

Sn=1.0136;%0.0110
Sn1=1.8369;
Sn2=4.4959;
Sn3=223.9508;
S= Sn;
S_045= Sn;
S_040= Sn;
S_010= Sn;
S_015= Sn;
r=0.00788;
%tau=1.25;
tau=0.5;
tau_045=0.45;
tau_040=0.40;
tau_010=0.4;
tau_015=0.4;
tau_020=0.4;
tau_025=0.4;
%vol=0.32;
vol=0.2;
bidask=0.0000;

CbsCollection_010=[];
ImpVolCollection_010=[];

CbsCollection_015=[];
ImpVolCollection_015=[];

CbsCollection_020=[];
ImpVolCollection_020=[];

CbsCollection_025=[];
ImpVolCollection_025=[];

KCollection=[];

narr=linspace(Sn*0.75,Sn*1.25,30);
narr1=linspace(Sn1*0.75,Sn1*1.25,30);
narr2=linspace(Sn2*0.75,Sn2*1.25,30);
%narr3=linspace(Sn3*0.75,Sn3*1.25,30);

for i = 1:numel(narr) %0.0090:0.0001:0.0125
    
    K=narr(i);
    K1=narr1(i);
    K2=narr2(i);
    %K3=narr3(i);
    
    Cbs_010=callPrice(Sn,tau_010,r,vol,K);
    %Cbs_010=putPrice(Sn,tau_010,r,vol,K);
    Cbs_015=callPrice(Sn1,tau_015,r,vol,K1);
    %Cbs_015=putPrice(Sn1,tau_015,r,vol,K1);
    Cbs_020=callPrice(Sn2,tau_020,r,vol,K2);
    %Cbs_020=putPrice(Sn2,tau_020,r,vol,K2);
    %Cbs_025=callPrice(Sn3,tau_025,r,vol,K3);
    
    Cbs_010=(Cbs_010*0.4734+0.0177+bidask)/0.4734;
    Cbs_015=(Cbs_015*0.3382+0.0383+bidask)/0.3382;
    Cbs_020=(Cbs_020*0.1595+0.1093+bidask)/0.1595;
    %Cbs_025=Cbs_025*0.0020+0.4850;%0.00392
    
    CbsCollection_010=[CbsCollection_010,Cbs_010];
    CbsCollection_015=[CbsCollection_015,Cbs_015];
    CbsCollection_020=[CbsCollection_020,Cbs_020];
    %CbsCollection_025=[CbsCollection_025,Cbs_025];

    %ImpVol_010 = impliedVol(Cbs_010, Sn, K, r, tau_010);
    ImpVol_010 = blsimpv(Sn, K, r, tau_010, Cbs_010,'Class', {'Call'});
    %ImpVol_015 = impliedVol(Cbs_015, Sn1, K1, r, tau_015);
    ImpVol_015 = blsimpv(Sn1, K1, r, tau_015, Cbs_015,'Class', {'Call'});
    %ImpVol_020 = impliedVol(Cbs_020, Sn2, K2, r, tau_020);
    ImpVol_020 = blsimpv(Sn2, K2, r, tau_020, Cbs_020,'Class', {'Call'});
    %ImpVol_025 = impliedVol(Cbs_025, Sn3, K3, r, tau_025);
    
    ImpVolCollection_010=[ImpVolCollection_010,ImpVol_010];
    ImpVolCollection_015=[ImpVolCollection_015,ImpVol_015];
    ImpVolCollection_020=[ImpVolCollection_020,ImpVol_020];
    %ImpVolCollection_025=[ImpVolCollection_025,ImpVol_025];
    
    KCollection(end+1)=K;
end

%K=linspace(40,100,13);


clf
figure;
plot(KCollection1,ImpVolCollection_010,'b-o','linewidth',1)
hold on;
plot(KCollection1,ImpVolCollection_015,'k-o','linewidth',1)
hold on;
plot(KCollection1,ImpVolCollection_020,'c-o','linewidth',1)
%hold on;
%plot(KCollection1,ImpVolCollection_025,'c-o','linewidth',1)
xlabel('LMMR, spread quotation','Interpreter','latex')
ylabel('Implied Volatility ($\sigma$)','Interpreter','latex')
% xlim([40 100]);
% ylim([0.30 0.4]);
% hold on
% plot(KCollection,ones(size(KCollection))*vol,'k--','linewidth',2)
h=legend('$\epsilon$=0.4','$\epsilon$=0.3','$\epsilon$=0.2','$\epsilon$=0.1');
set(h,'Interpreter','latex','FontSize',12,'location','best') 

figure;
plot(KCollection1,CbsCollection_010,'b-','linewidth',1)
hold on;
plot(KCollection1,CbsCollection_015,'k-','linewidth',1)
hold on;
plot(KCollection1,CbsCollection_020,'c-','linewidth',1)
%hold on;
%plot(KCollection1,CbsCollection_025,'c-','linewidth',1)
xlabel('LMMR, spread quotation','Interpreter','latex')
ylabel('Option Price','Interpreter','latex')
h=legend('$\epsilon$=0.4','$\epsilon$=0.3','$\epsilon$=0.2','$\epsilon$=0.1');
set(h,'Interpreter','latex','FontSize',12,'location','best') 
