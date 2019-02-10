syms x
f =[x*(x-1) x*(x-1)^2 x*(x-1)^3];
df = diff(f,x);
A = 1;
B = 1+dirac(x - 0.5);
M = zeros(length(f),length(f));
K = zeros(length(f),length(f));
c = A*df;
d = diff(c);
for i = 1:length(f)
for j=1:length(f)
M(i,j)=int((B*f(i).*f(j)),x,[0,1]); 
end 
end 
for i = 1:length(df)
for j=1:length(df)
K(i,j)= int((-f(i).*d(j)),x,[0,1]); 
end 
end
display(M);
display(K);
e = eig(inv(M)*K);
w = sqrt(e);
[V,D] = eig(inv(M)*K);
phi1= vpa(f*V(1:length(V),1))
phi2= vpa(f*V(1:length(V),2))
phi3= vpa(f*V(1:length(V),3))
clear syms x
x = 0:0.01:1;
% phi1;
% phi2;
% phi3;
% plot(x,phi1);
% hold on
% plot(x,phi2);
% hold on
% plot(x,phi3);