function [ VaR ] = GARCHt( p,ts )
res=ts;
res2=res.^2; 
%Use GARCH(1,1)to calculate VaR for one-period ahead forecast
[para_vec1, LogLik1, sig21]=GARCH11est(res2);
predicted1(1,1) = para_vec1'*[1; res2(end,1); sig21(end,1)]; 
k=kurtosis(ts);
df=4+6/(k-3);
VaR=tinv((1-p),df)*sqrt(predicted1(1,1));
end