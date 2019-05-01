function[phi_vec, Cov, LogLik, sig2, res]=ARest(rtn, p)

T = length(rtn); 

Y = rtn(p+1:end); 

X = ones(length(Y),1); 
for i=p:-1:1
   X = [X, rtn(i:end-p+i-1)]; 
end

phi_vec = (X'*X)\(X'*Y);
res = Y - X*phi_vec;
sig2 = mean(res.^2);
Cov = sig2*inv(X'*X); 

LogLik = -((T-p)/2)*log(2*pi) - ((T-p)/2)*log(sig2) ...
    - sum(res.^2)/(2*sig2); 
