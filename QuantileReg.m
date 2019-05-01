function [ VaR ] = QuantileReg( p,ts,VIX )
res=ts;
res2=res.^2;
T=length(ts);
 
%estimate garch(1,1)using ARMA(0,0)for the mean process.
f=@(para)MLEGarch11(para,res2);
[para,L]=fmincon(f,[0,0,0],[0,1,1],[1],[],[],[0,0,0],[1,1,1]);
 
%calculate sigma^2
sigma2=zeros(length(res2),1);
sigma2(1)=mean(res2);
 
for i=2:length(res2)
    sigma2(i)=para(1)+para(2)*res2(i-1)+para(3)*sigma2(i-1);
end

sigma2lag(1,1)=mean(sigma2);
VIXlag(1,1)=mean(VIX);
for j=2:length(sigma2)
    sigma2lag(j,1)=sigma2(j-1);
    VIXlag(j,1)=VIX(j-1);
end
sigmalag=sqrt(sigma2lag);

x=[ones(length(sigmalag),1),VIXlag,sigmalag];
y=ts;
pmean=x\y;
rho=@(r)sum(abs(r.*(1-p-(r<0))));
beta=fminsearch(@(beta)rho(y-x*beta),pmean);%find coefficients of explainary variables

Cov = (mean((y - x*beta).^2))*inv(x'*x); 
tstats=beta'./diag(sqrt(Cov))';
pvalues = 2*(1-tcdf(abs(tstats),length(VIX)-1)); %find coefficients t-stats and p-value

VaR=x(end,:)*beta;

end

