function[theta_vec, LogLik, sig2, res]=MAest(rtn, q)

T = length(rtn); 

theta_guess = [mean(rtn); zeros(q,1)]; % initial guess on the parameter values

[theta_vec, fval] = fminsearch(@(x) MA_obj(x,rtn,q), theta_guess); 

LogLik = -fval; 

res = zeros(T,1); 

res(1) = rtn(1) - theta_vec(1); 

for t=2:T
   if t<=q
       res(t) = rtn(t) - theta_vec(1) + theta_vec(2:t)'*flipud(res(1:t-1,1)); 
   else
       res(t) = rtn(t) - theta_vec(1) + theta_vec(2:end)'*flipud(res(t-q:t-1,1));      
   end    
end

sig2 = mean(res.^2); 