function Cbs=callPrice(S,tau,r,vol,K)
% This computes the Black-Scholes price of a European call option
%
% Inputs:
%        S : current price of the underlying asset
%      tau : remaining time until maturity of the option
%        r : risk-free interest rate
%      vol : volatility of the underlying asset price 
%        K : strike price
%
% Outputs:
%        Cbs : Black-Scholes price of the call option

d_plus  = 1./(sqrt(vol.^2*tau)).*(log(S./K)+(r+tau.*(r+1/2.*vol.^2)));
d_minus = 1./(sqrt(vol.^2*tau)).*(log(S./K)+(r+tau.*(r-1/2.*vol.^2)));

Cbs=S.*normcdf(d_plus)-K.*exp(-r.*tau).*normcdf(d_minus);

end