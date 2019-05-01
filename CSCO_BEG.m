%Basic stats and preliminary tests
%Table 3.1 & Figure 3.1

clear all
clc
load('CSCO9716.mat')
rtn=-1*log(1+Returns);
%rtn1=rtn(1:1512); %for the high-volatility period
%rtn2=rtn(3523:5034); % for the low-volatility period
T=length(rtn);
mean=mean(rtn);
std=std(rtn);
skewness=skewness(rtn);
kurtosis=kurtosis(rtn);
%histfit(rtn)
[stat1,pval1]=JBtest(rtn); %normality test

[stat2,pval2]=LBtest(rtn, 12)%LB test on r

[para_vec, LogLik, sig2, res] = ARMA11est(rtn); %ARMA(1,1) for the high-volatility period.
%res=rtn; %For the low-volatility period, no ARMA process
res2=res.^2; %Getting the residual-squared series a^2 

[stat3, pval3]=LBtest(res,12); %LB test on a
[stat4, pval4]=LBtest(res2,12); %LB test on a^2

%plot the entire sample 
d=datestr(Date,'mm/dd/yyyy');
ts1=timeseries(rtn,d);
plot(ts1)
 


