function[Obj] = ARMA11_obj(para, rtn)

T = length(rtn); 

phi0 = para(1); 
phi1 = para(2); 
theta1 = para(3); 
muhat = phi0 /(1-phi1); 

res = zeros(T,1); 

res(1) = rtn(1) - muhat; 

for t=2:T
    res(t) = rtn(t) - phi0 -phi1*rtn(t-1) + theta1*res(t-1);      
end

sig2 = mean(res.^2); 

Obj = (T/2)*log(2*pi) +(T/2)*log(sig2) + sum(res.^2)/(2*sig2);