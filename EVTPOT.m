function [ VaR ] = EVTPOT( p, ts)
%eta is the threshold
ts1=ts-mean(ts);
T=length(ts1);

%estimate the quantile using simple fixed quantile
%k=T^(2/3)/log(log(T))proposed by Loretan & Phillips (1994) and used in
%later literature
k=T^(2/3)/log(log(T));
eta=quantile(ts1,1-k/T);
x=ts1(find(ts(1:T)>eta));
D=252;
N=length(x);
f=@(para)-MLENEWEVT(para,x,T,D,eta,N);
[para]=fminsearch(f,[0.001,0.001,0.001]);
a=1+para(1)*(min(x)-para(3))/para(2);
VaR=para(3)-para(2)/para(1)*(1-(-1*D*log(1-p)).^(-para(1)));
end

