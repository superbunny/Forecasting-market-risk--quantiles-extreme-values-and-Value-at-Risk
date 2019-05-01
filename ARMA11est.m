function[para_vec, LogLik, sig2, res]=ARMA11est(rtn)

T = length(rtn); 

para_guess = zeros(3,1); % initial guess on the parameter values
% First one: phi_0, Second one: phi_1, Third one: theta_1

[para_vec, fval] = fminsearch(@(x) ARMA11_obj(x,rtn), para_guess); 

LogLik = -fval; 

phi0 = para_vec(1); 
phi1 = para_vec(2); 
theta1 = para_vec(3); 
muhat = phi0 /(1-phi1); 


res = zeros(T,1); 

res(1) = rtn(1) - muhat; 

for t=2:T
    res(t) = rtn(t) - phi0 -phi1*rtn(t-1) + theta1*res(t-1);      
end

sig2 = mean(res.^2); 