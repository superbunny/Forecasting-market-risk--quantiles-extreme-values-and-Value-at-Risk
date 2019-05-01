function [ VaR ] = ARMAGARCH( p,ts )
[para_vec, LogLik, sig2, res] = ARMA11est(ts); %ARMA(1,1) estimation
phi0 = para_vec(1); 
phi1 = para_vec(2); 
theta1 = para_vec(3); 
predicted(1,1) = phi0 + phi1*ts(end) - theta1*res(end); %get one-step ahead return forecasting rt(1)
res2=res.^2; %Getting the residual-squared series a^2 from ARMA(1,1)
%Use ARMA(1,1)-GARCH(1,1)to calculate VaR for one-period ahead forecast
[para_vec1, LogLik1, sig21]=GARCH11est(res2);
predicted1(1,1) = para_vec1'*[1; res2(end,1); sig21(end,1)]; %get one-step ahead return forecasting sigmat(1)
VaR=predicted(1,1)+norminv(1-p)*sqrt(predicted1(1,1));
end

