function [ L ] = MLENEWEVT( para,x,T,D,eta,N )
%para1 is xi, para2 is alpha, para3 is beta, x is the negative log returns that exceed
%the threshold, T is total number of observations,D is the baseline time
%interval
for i=1:N
    a(i,1)=-log(D)-log(para(2))-(1/para(1)+1)*log(1+para(1)*(x(i)-para(3))/para(2));
end
L=sum(a)-T/D*(1+para(1)*(eta-para(3))/para(2)).^(-1/para(1));