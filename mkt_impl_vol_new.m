clear all;

StrikeHY=[ 950000 960000 970000 980000 990000 1000000 1005000 1010000 1015000 1020000 1025000 1030000 1035000 1040000 1045000 1050000 1055000 1060000 1070000 1080000 1090000 1095000 1100000 1105000 1110000 1120000];
StrikeHY=StrikeHY.*10^(-4);

StrikeIG=[ 4000 4500 5000 5500 6000 6250 6500 6750 7000 7250 7500 7750 8000 8250 8500 8750 9000 9250 9500 9750 10000 10500 11000 11500 12000 ];
StrikeIG=StrikeIG.*10^(-2);

RecIG_1m=[ 0.0061433 0.00363136 0.00147336 0.00044753 0.00016971 0.00011488 0.00009357 0.00007048 0.00006052 0.00004746 0.00003783 0.00003047 0.00002493 0.00002195 0.00002 0.00001752 0.00001531 0.00001272 0.00001043 0.00001053 0.00000903 0.00000682 0.00000533 0.00000429 0.00000356];
RecIG_2m=[ 0.00652948 0.00415653 0.00218574 0.00111464 0.0006729 0.00053817 0.00044259 0.00037125 0.00031599 0.00027163 0.00023654 0.00020567 0.00018075 0.00016002 0.00014145 0.00012359 0.0001191 0.00010458 0.00009136 0.00008083 0.00007185 0.00005669 0.00004546 0.00003703 0.0000319 ];
RecIG_3m=[ 0.00688087 0.00462557 0.00283761 0.00173813 0.00118869 0.00100358 0.00086282 0.00075294 0.00066275 0.00059574 0.00053951 0.00048165 0.00043986 0.00040167 0.0003691 0.0003409 0.00031478 0.00028538 0.00025663 0.00023461 0.00021334 0.00017749 0.00014789 0.00011929 0.00009939 ];
RecIG_6m=[ 0.00803973 0.00615159 0.00467727 0.00363599 0.00291753 0.00258163 0.00236639 0.00219116 0.0020333 0.00189715 0.00179071 0.0016803 0.00159008 0.0015018 0.00143267 0.00135917 0.00130151 0.00122524 0.00115404 0.00109259 0.00098636 0.00088583 0.00079796 0.00071884 0.0006547 ];
PayIG_1m=[ 0.00000503 0.00004675 0.0003843 0.0019403 0.00426437 0.00547864 0.00672419 0.00795609 0.00921673 0.010453 0.0117173 0.01295262 0.01420118 0.01546305 0.01669376 0.01795223 0.01917859 0.02043217 0.02165305 0.02290244 0.02411848 0.02659012 0.02908958 0.0315256 0.03398821 ];
PayIG_2m=[ 0.00002752 0.00005688 0.00067767 0.00219741 0.00427301 0.00539183 0.00654689 0.00772645 0.00891678 0.01011636 0.01132255 0.0125304 0.01373402 0.01494614 0.01615934 0.01737239 0.01858471 0.01979218 0.02100872 0.02221578 0.02342182 0.02582903 0.02821694 0.03061004 0.03300875 ];
PayIG_3m=[ 0.00005911 0.00021871 0.00092332 0.00237841 0.00430673 0.00534956 0.00644311 0.00756521 0.00870594 0.00985607 0.01102259 0.01218929 0.01335954 0.0145387 0.01571873 0.01689707 0.01808121 0.01925627 0.02042513 0.02160766 0.02278479 0.0251361 0.02747465 0.02983014 0.03215705 ];
PayIG_6m=[ 0.00013026 0.00058052 0.00147764 0.00281048 0.00439187 0.00530936 0.00625182 0.0072532 0.00826187 0.00929271 0.01034221 0.01139324 0.01245593 0.01352653 0.01454544 0.01568813 0.01670654 0.01777518 0.01885747 0.01993697 0.02099629 0.02318493 0.02534098 0.02753639 0.02981198 ];

RecHY_1m=[ 0.00004798 0.00006337 0.00008496 0.00011579 0.00016049 0.0001285 0.00014441 0.00016435 0.00018801 0.00021599 0.00025009 0.00029274 0.00030382 0.00037036 0.00045588 0.00056994 0.00072331 0.00090549 0.00144191 0.00250967 0.00491723 0.00720595 0.01063242 0.01494249 0.01944174 0.02922646];
RecHY_2m=[ 0.00041525 0.0005123 0.00061958 0.00075774 0.00093928 0.00110273 0.00118519 0.00128532 0.00139386 0.00151916 0.00165313 0.0018303 0.00200744 0.00222991 0.00249722 0.00281396 0.00319678 0.00362579 0.00488457 0.00679197 0.00996545 0.01239734 0.01551574 0.01940809 0.0238675 0.03317863];
RecHY_3m=[ 0.00119844 0.00138453 0.00158265 0.00183189 0.00214777 0.00246861 0.00260936 0.00278362 0.00297901 0.00318651 0.00342767 0.00370866 0.00402269 0.00438703 0.0048115 0.00528827 0.00589296 0.00654315 0.00829109 0.01068946 0.01447381 0.01701017 0.02012565 0.02389131 0.02820574 0.03735482];
RecHY_6m=[ 0.00527476 0.00577476 0.00629718 0.00690229 0.00764583 0.00841287 0.00874272 0.00915118 0.00958776 0.01005002 0.01053741 0.01115323 0.01200999 0.0127737 0.01362361 0.01452658 0.01562645 0.01675995 0.01961712 0.02329246 0.02723818 0.03013276 0.03343349 0.03717379 0.04125746 0.05048495];
PayHY_1m=[ 0.14080118 0.13081088 0.12082388 0.1108626 0.10086617 0.09090001 0.08592142 0.08094683 0.07597656 0.07101189 0.06604383 0.06108955 0.05616212 0.05121105 0.0462972 0.0414232 0.03655451 0.03172636 0.02210608 0.0128667 0.0054272 0.0027218 0.00106231 0.00053649 0.00021344 0.00005218];
PayHY_2m=[ 0.13730304 0.12738706 0.11748508 0.10760742 0.09776604 0.08797359 0.08304208 0.0781546 0.07327837 0.06841711 0.06355642 0.05873172 0.05394195 0.04914367 0.04441413 0.03972306 0.03509924 0.03051315 0.02151118 0.01343788 0.00657938 0.00400238 0.0021185 0.00117044 0.0005803 0.00015497];
PayHY_3m=[ 0.13423358 0.12441479 0.11461671 0.10484328 0.0951463 0.08550855 0.0806555 0.07583735 0.07103413 0.06624342 0.06148296 0.056767 0.05208022 0.04742527 0.04282828 0.03803125 0.03362101 0.02928347 0.02103339 0.01355282 0.00723728 0.00478897 0.00315417 0.00194454 0.0011475 0.00032549];
PayHY_6m=[ 0.12547013 0.11594608 0.10649124 0.09709576 0.08784713 0.07861388 0.07394323 0.06936656 0.06480359 0.06026096 0.05572745 0.05130998 0.04700736 0.04259009 0.03839408 0.03430057 0.03055435 0.02676714 0.01958989 0.01328651 0.00795072 0.00585992 0.00408563 0.0027964 0.00182316 0.0006292];

t1m=0.05556;
t2m=0.13333;
t3m=0.21111;
t6m=0.46389;

SpreadHY=299.00;
SpreadIG=51.23;
PriceHY=109.3570;
PriceIG=102.4780;
r=0.00778;

multi=100;
RecIG_1m=RecIG_1m.*multi;
RecIG_2m=RecIG_2m.*multi;
RecIG_3m=RecIG_3m.*multi;
RecIG_6m=RecIG_6m.*multi;
PayIG_1m=PayIG_1m*multi;
PayIG_2m=PayIG_2m*multi;
PayIG_3m=PayIG_3m*multi;
PayIG_6m=PayIG_6m*multi;
RecHY_1m=RecHY_1m.*multi;
RecHY_2m=RecHY_2m.*multi;
RecHY_3m=RecHY_3m.*multi;
RecHY_6m=RecHY_6m.*multi;
PayHY_1m=PayHY_1m*multi;
PayHY_2m=PayHY_2m*multi;
PayHY_3m=PayHY_3m*multi;
PayHY_6m=PayHY_6m*multi;

%% put HY
figure;
plot(StrikeHY,RecHY_1m,'b-','linewidth',1);
hold on
plot(StrikeHY,RecHY_2m,'k-','linewidth',1);
hold on
plot(StrikeHY,RecHY_3m,'c-','linewidth',1);
hold on
plot(StrikeHY,RecHY_6m,'r-','linewidth',1);
xlabel('Strike (K), in index level %')
ylabel('Option Price')
% title('CDX.NA.HY Receiver Option Quoted Price')
legend('1m Receiver CDX.NA.HY Option','2m Receiver CDX.NA.HY Option','3m Receiver CDX.NA.HY Option','6m Receiver CDX.NA.HY Option','location','best')

volHY_1ms=[];
volHY_2ms=[];
volHY_3ms=[];
volHY_6ms=[];

for i = 1:numel(StrikeHY)
    volHY_1m = blsimpv(PriceHY, StrikeHY(i), r, t1m, RecHY_1m(i),'Class', {'Put'});
    volHY_2m = blsimpv(PriceHY, StrikeHY(i), r, t2m, RecHY_2m(i),'Class', {'Put'});
    volHY_3m = blsimpv(PriceHY, StrikeHY(i), r, t3m, RecHY_3m(i),'Class', {'Put'});
    volHY_6m = blsimpv(PriceHY, StrikeHY(i), r, t6m, RecHY_6m(i),'Class', {'Put'});
    volHY_1ms(end+1)=volHY_1m;
    volHY_2ms(end+1)=volHY_2m;
    volHY_3ms(end+1)=volHY_3m;
    volHY_6ms(end+1)=volHY_6m;
end

figure;
plot(StrikeHY,volHY_1ms,'b-o','linewidth',1)
hold on;
plot(StrikeHY,volHY_2ms,'k-o','linewidth',1)
hold on;
plot(StrikeHY,volHY_3ms,'c-o','linewidth',1)
hold on;
plot(StrikeHY,volHY_6ms,'r-o','linewidth',1)
xlabel('Strike (K), in index level %')
ylabel('Volatility (\sigma)')
% title('CDX.NA.HY Receiver Option Implied Vol')
legend('\sigma_{1m}','\sigma_{2m}','\sigma_{3m}','\sigma_{6m}','location','best')

%% call HY
% figure;
% plot(StrikeHY,PayHY_1m,'b-','linewidth',1);
% hold on
% plot(StrikeHY,PayHY_2m,'k-','linewidth',1);
% hold on
% plot(StrikeHY,PayHY_3m,'c-','linewidth',1);
% hold on
% plot(StrikeHY,PayHY_6m,'r-','linewidth',1);
% xlabel('Strike (K)')
% ylabel('Option Price')
% % title('CDX.NA.HY Payer Option Quoted Price')
% legend('1m Payer CDX.NA.HY option','2m Payer CDX.NA.HY option','3m Payer CDX.NA.HY option','6m Payer CDX.NA.HY option','location','best')
% 
% volHY_1ms=[];
% volHY_2ms=[];
% volHY_3ms=[];
% volHY_6ms=[];
% 
% for i = 1:numel(StrikeHY)
%     volHY_1m = blsimpv(PriceHY, StrikeHY(i), r, t1m, PayHY_1m(i),'Class', {'Call'});
%     %volHY_1m = impliedVol(PayHY_1m(i), PriceHY, StrikeHY(i), r, t1m,1);
%     volHY_2m = blsimpv(PriceHY, StrikeHY(i), r, t2m, PayHY_2m(i),'Class', {'Call'});
%     %volHY_2m = impliedVol(PayHY_2m(i), PriceHY, StrikeHY(i), r, t2m,1);
%     volHY_3m = blsimpv(PriceHY, StrikeHY(i), r, t3m, PayHY_3m(i),'Class', {'Call'});
%     %volHY_3m = impliedVol(PayHY_3m(i), PriceHY, StrikeHY(i), r, t3m,1);
%     volHY_6m = blsimpv(PriceHY, StrikeHY(i), r, t6m, PayHY_6m(i),'Class', {'Call'});
%     %volHY_6m = impliedVol(PayHY_6m(i), PriceHY, StrikeHY(i), r, t6m,1);
%     volHY_1ms(end+1)=volHY_1m;
%     volHY_2ms(end+1)=volHY_2m;
%     volHY_3ms(end+1)=volHY_3m;
%     volHY_6ms(end+1)=volHY_6m;
% end
% 
% figure;
% plot(StrikeHY,volHY_1ms,'b-o','linewidth',1)
% hold on;
% plot(StrikeHY,volHY_2ms,'k-o','linewidth',1)
% hold on;
% plot(StrikeHY,volHY_3ms,'c-o','linewidth',1)
% hold on;
% plot(StrikeHY,volHY_6ms,'r-o','linewidth',1)
% xlabel('Strike (K)')
% ylabel('Volatility (\sigma)')
% % title('CDX.NA.HY Payer Option Implied Vol')
% legend('\sigma_{1m}','\sigma_{2m}','\sigma_{3m}','\sigma_{6m}','location','best')

%% call IG
figure;
plot(StrikeIG,RecIG_1m,'b-','linewidth',1);
hold on
plot(StrikeIG,RecIG_2m,'k-','linewidth',1);
hold on
plot(StrikeIG,RecIG_3m,'c-','linewidth',1);
hold on
plot(StrikeIG,RecIG_6m,'r-','linewidth',1);
xlabel('Strike (K)')
ylabel('Option Price')
title('CDX.NA.IG Receiver Option Quoted Price')
legend('\sigma_{1m}','\sigma_{2m}','\sigma_{3m}','\sigma_{6m}','location','best')

volIG_1ms=[];
volIG_2ms=[];
volIG_3ms=[];
volIG_6ms=[];

for i = 1:numel(StrikeIG)
    volIG_1m = blsimpv(SpreadIG, StrikeHY(i), r, t1m, RecIG_1m(i),'Class', {'Call'});
    volIG_2m = blsimpv(SpreadIG, StrikeHY(i), r, t2m, RecIG_2m(i),'Class', {'Call'});
    volIG_3m = blsimpv(SpreadIG, StrikeHY(i), r, t3m, RecIG_3m(i),'Class', {'Call'});
    volIG_6m = blsimpv(SpreadIG, StrikeHY(i), r, t6m, RecIG_6m(i),'Class', {'Call'});
    volIG_1ms(end+1)=volIG_1m;
    volIG_2ms(end+1)=volIG_2m;
    volIG_3ms(end+1)=volIG_3m;
    volIG_6ms(end+1)=volIG_6m;
end

figure;
plot(StrikeIG,volIG_1ms,'b-o','linewidth',1)
hold on;
plot(StrikeIG,volIG_2ms,'k-o','linewidth',1)
hold on;
plot(StrikeIG,volIG_3ms,'c-o','linewidth',1)
hold on;
plot(StrikeIG,volIG_6ms,'r-o','linewidth',1)
xlabel('Strike (K), in spread bps')
ylabel('Volatility (\sigma)')
title('CDX.NA.IG Receiver Option Implied Vol')
legend('\sigma_{1m}','\sigma_{2m}','\sigma_{3m}','\sigma_{6m}','location','best')
%% put IG
% figure;
% plot(StrikeIG,PayIG_1m,'b-','linewidth',1);
% hold on
% plot(StrikeIG,PayIG_2m,'k-','linewidth',1);
% hold on
% plot(StrikeIG,PayIG_3m,'c-','linewidth',1);
% hold on
% plot(StrikeIG,PayIG_6m,'r-','linewidth',1);
% xlabel('Strike (K)')
% ylabel('Option Price')
% % title('CDX.NA.IG Payer Option Quoted Price')
% legend('1m Payer CDX.NA.IG option','2m Payer CDX.NA.IG option','3m Payer CDX.NA.IG option','6m Payer CDX.NA.IG option','location','best')
% 
% volIG_1ms=[];
% volIG_2ms=[];
% volIG_3ms=[];
% volIG_6ms=[];
% 
% for i = 1:numel(StrikeIG)
%     volIG_1m = blsimpv(SpreadIG, StrikeIG(i), r, t1m, PayIG_1m(i),'Class', {'Put'});
%     %volIG_1m = impliedVol(PayIG_1m(i), SpreadIG, StrikeIG(i), r, t1m,1);
%     volIG_2m = blsimpv(SpreadIG, StrikeIG(i), r, t2m, PayIG_2m(i),'Class', {'Put'});
%     %volIG_2m = impliedVol(PayIG_2m(i), SpreadIG, StrikeIG(i), r, t2m,1);
%     volIG_3m = blsimpv(SpreadIG, StrikeIG(i), r, t3m, PayIG_3m(i),'Class', {'Put'});
%     %volIG_3m = impliedVol(PayIG_3m(i), SpreadIG, StrikeIG(i), r, t3m,1);
%     volIG_6m = blsimpv(SpreadIG, StrikeIG(i), r, t6m, PayIG_6m(i),'Class', {'Put'});
%     %volIG_6m = impliedVol(PayIG_6m(i), SpreadIG, StrikeIG(i), r, t6m,1);
%     volIG_1ms(end+1)=volIG_1m;
%     volIG_2ms(end+1)=volIG_2m;
%     volIG_3ms(end+1)=volIG_3m;
%     volIG_6ms(end+1)=volIG_6m;
% end
% 
% figure;
% plot(StrikeIG,volIG_1ms,'b-o','linewidth',1)
% hold on;
% plot(StrikeIG,volIG_2ms,'k-o','linewidth',1)
% hold on;
% plot(StrikeIG,volIG_3ms,'c-o','linewidth',1)
% hold on;
% plot(StrikeIG,volIG_6ms,'r-o','linewidth',1)
% xlabel('Strike (K)')
% ylabel('Volatility (\sigma)')
% % title('CDX.NA.IG Payer Option Implied Vol')
% legend('\sigma_{1m}','\sigma_{2m}','\sigma_{3m}','\sigma_{6m}','location','best')
