function[Obj] = MA_obj(theta, rtn, q)

T = length(rtn); 

res = zeros(T,1); 

res(1) = rtn(1) - theta(1); 

for t=2:T
   if t<=q
       res(t) = rtn(t) - theta(1) + theta(2:t)'*flipud(res(1:t-1,1)); 
   else
       res(t) = rtn(t) - theta(1) + theta(2:end)'*flipud(res(t-q:t-1,1));      
   end    
end

sig2 = mean(res.^2); 

Obj = (T/2)*log(2*pi) +(T/2)*log(sig2) + sum(res.^2)/(2*sig2);
