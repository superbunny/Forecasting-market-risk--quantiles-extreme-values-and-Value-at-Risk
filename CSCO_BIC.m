%Using BIC to choose ARMA lags
% Table 3.1

clear all
clc
load('CSCO9716.mat')
rtn1=log(1+Returns);
rtn=rtn1(1:1512);% for the high-volatility period
%rtn=rtn1(3523:5034);% for the low-volatility period
L=6;
T=length(rtn);
BIC_stat1 = zeros(L,1); %choosing AR lags
for l=1:L
    [~, ~, LogLik1] = ARest(rtn,l);
    BIC_stat1(l,1) = (-2/T)*LogLik1 + (log(T)/T)*l;
    
end

BIC_stat2 = zeros(L,1); %choosing MA lags
for m=1:L
    [~, ~, LogLik2] = MAest(rtn,m);
    BIC_stat2(m,1) = (-2/T)*LogLik2 + (log(T)/T)*m;
    
end