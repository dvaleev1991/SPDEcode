% This function finds Black-Scholes implied volatility of a call.
%
% Inputs: 
%        Cm : market price of a call
%         S : current price of the underlying asset
%       tau : remaining time until maturity of the option
%         r : risk-free interest rate 
%         K : strike price
%
% Outputs:
%    impVol : Black-Scholes implied volatility of a call

function impVol = impliedVol(Cm, S, K, r, tau)
            
            % Determine the no-arbitrage bounds
            %lowerBound = max(S - K*exp(-r*tau), 0); 
            lowerBound = 0; 
            upperBound = S;
            
            % Handler : market price is outside no-arbitrage bounds
            if Cm > upperBound      
               impVol='Error: Market price breached no-arbitrage limits';
            elseif (Cm < lowerBound)
               impVol='Error: Market price breached no-arbitrage limits';        
            
            % Handler : market price is at the no-arbitrage bounds
            elseif (Cm == upperBound) 
               impVol = Inf;
            elseif (Cm == lowerBound) 
               impVol = 0.0000;
               
            % Compute Black-Scholes implied volatility   
            else                  
               f = @(impVol) (callPrice(S, tau, r, impVol, K) - Cm);
               impVol = fzero(f, 0.5); 
            end
end