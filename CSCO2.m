% Low-volatility backtesting
% Table 3.4 and Figure 3.2
clear all
clc
load('CSCO9716.mat')
rtn=log(1+Returns);
rtn1=rtn(3523:5034);
y=-1*rtn1;
T=length(y);
p=0.01;
VaR=NaN(T,6);
start=T-756;
for t=start+1:T
    t1=t-start;
    t2=t-1;
    window=y(t1:t2);
    VaR(t,1)=RiskMetrics(p,window);
    VaR(t,2)=GARCHt(p,window);
    VaR(t,3)=quantile(window,1-p);
    VaR(t,4)=QuantileReg(p,window,VIX);
    VaR(t,5)=EVTBM(p,21,window); 
    VaR(t,6)=EVTPOT(p,window);
end

x1=y(start+1:T);
x2=VaR(start+1:T,1);
x3=VaR(start+1:T,2);
x4=VaR(start+1:T,3);
x5=VaR(start+1:T,4);
x6=VaR(start+1:T,5);
x7=VaR(start+1:T,6);

Date1=Date(4279:5034);
d=datestr(Date1,'mm/dd/yyyy');
ts1=timeseries(x1,d);
ts2=timeseries(x2,d);
ts3=timeseries(x3,d);
ts4=timeseries(x4,d);
ts5=timeseries(x5,d);
ts6=timeseries(x6,d);
ts7=timeseries(x7,d);

ts1.TimeInfo.Format = 'mm/dd/yyyy';
ts2.TimeInfo.Format = 'mm/dd/yyyy';
ts3.TimeInfo.Format = 'mm/dd/yyyy';
ts4.TimeInfo.Format = 'mm/dd/yyyy';
ts5.TimeInfo.Format = 'mm/dd/yyyy';
ts6.TimeInfo.Format = 'mm/dd/yyyy';
ts7.TimeInfo.Format = 'mm/dd/yyyy';

subplot(3,1,1);
plot(ts1)
hold on
plot(ts2)
hold on
plot(ts3)
legend({'Daily negative log returns','RiskMetrics','Student-t-GARCH(1,1)'},'FontSize',10)

subplot(3,1,2);
plot(ts1)
hold on
plot(ts4)
hold on
plot(ts5)
legend({'Daily negative log returns','Empirical Quantile','Quantile regression'},'FontSize',10)

subplot(3,1,3);
plot(ts1)
hold on
plot(ts6)
hold on
plot(ts7)
legend({'Daily negative log returns','BM-EVT','POT-EVT'},'FontSize',10)

for i=1:6
    VR=length(find(y(start+1:T)>VaR(start+1:T,i)))/(p*(T-start));%violation ratio
    s=std(VaR(start+1:T,i));%VaR volatility
    disp([i VR s])
end