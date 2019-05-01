function [ VaR ] = EVTBM( p,n,ts )
T=length(ts);
g=fix(T/n)-1;
for i=0:g-1
r(1+i,1)=max(ts((1+n*i):(n+n*i)));
end

%if xi !=0
f=@(para)-MLEEVT(para,r,g);
[para]=fminsearch(f,[0.0001,0.0001,0.0001]);

VaR=para(3)-para(2)/para(1)*(1-(-n*log(1-p)).^(-para(1)));

%if xi=0
%f=@(para1)-MLEEVT1(para1,r,g);
%[para1,L]=fminsearch(f,[0.001,0.001])
 
%p=0.01;
%VaR1=para1(2)-para1(1)*log(-n*log(1-p))
