% Jarque-Bera test

function[stat, pval] = JBtest(Y)

T = length(Y); 

mu_hat = mean(Y) 
var_hat = sum((Y-mu_hat).^2)/(T-1)
S_hat = sum((Y-mu_hat).^3)/((T-1)*(var_hat^1.5))
K_hat = sum((Y-mu_hat).^4)/((T-1)*(var_hat^2))

t1 = S_hat / sqrt(6/T);
t2 = (K_hat - 3) / sqrt(24/T);

stat = t1^2 + t2^2; 
pval = chi2cdf(stat,2,'upper'); 
