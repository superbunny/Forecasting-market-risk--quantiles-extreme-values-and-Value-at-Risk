function [ L ] = MLEEVT( para,r,g )
%para1 is xi, para2 is alpha, para3 is beta
a=zeros(g,1);
for i=1:g
    a(i,1)=-log(para(2))-(1/para(1)+1)*log(1+para(1)*(r(i)-para(3))/para(2))-(1+para(1)*(r(i)-para(3))/para(2)).^(-1/para(1));
end
L=sum(a);
