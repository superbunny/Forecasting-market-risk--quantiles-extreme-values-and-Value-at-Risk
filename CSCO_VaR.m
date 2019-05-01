%Table 3.2

clear all
clc
load('CSCO9716.mat')
rtn=-1*log(1+Returns);
y=rtn;
p=0.05;
%p=0.01 and p=0.05 for alternatives
VaR(1,1)=RiskMetrics(p,y);
VaR(2,1)=ARMAGARCHt(p,y);
VaR(3,1)=ARMAGARCH(p,y);
VaR(4,1)=quantile(y,1-p);
VaR(5,1)=QuantileReg(p,y,VIX);
VaR(6,1)=EVTBM(p,21,y); 
VaR(7,1)=EVTPOT(p,y);
VaR'

