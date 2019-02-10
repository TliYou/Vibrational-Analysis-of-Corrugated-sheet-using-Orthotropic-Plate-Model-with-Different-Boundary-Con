syms x 
f =[(x^2)*(x-1)^3 (x^2)*(x-1)^4 (x^2)*(x-1)^5];
df = diff(f,x,2);
ddf = diff(f,x,4);
M = zeros(length(f),length(f));
K = zeros(length(f),length(f));

for i = 1:length(f)
for j=1:length(f)
M(i,j)=int((((f(i).*f(j))-(f(i).*df(j)))),x,[0,1]); 
end 
end 
for i = 1:length(df)
for j=1:length(df)
K(i,j)= int((f(i).*ddf(j)),x,[0,1]); 
end 
end
F = [(0.5^2)*(0.5-1)^3;(0.5^2)*(0.5-1)^4;(0.5^2)*(0.5-1)^5]
display(M);
display(K);
e = eig(inv(M)*K);
w = sqrt(e);
