function [ VaR ] = RiskMetrics( p,ts )
res=ts;
res2=res.^2;
T=length(ts);

%estimate garch(1,1)using ARMA(0,0)for the mean process.
f=@(para)MLEGarch11(para,res2);
[para]=fmincon(f,[0,0,0],[],[],[0,1,1],[1],[0,0,0],[1,1,1]);

%calculate sigma^2(t+1)
sigma2=zeros(length(res2),1);
sigma2(1)=mean(res2);
 
for i=2:length(res2)
    sigma2(i)=para(1)+para(2)*res2(i-1)+para(3)*sigma2(i-1);
end

forecast1=para(1)+para(2)*res2(end)+para(3)*sigma2(end);

%calculate VaR
VaR=norminv(1-p)*sqrt(1)*sqrt(forecast1);

end

