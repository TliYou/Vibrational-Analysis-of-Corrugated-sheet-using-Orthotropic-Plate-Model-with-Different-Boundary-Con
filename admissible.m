function [admissiblefun ,diffadmissiblefun] = admissible(x)
admissiblefun = @(x)[x^2,x^3,x^4];
diffadmissiblefun = zeros(1, length(admissiblefun));
for i= 1: length(admissiblefun)
diffadmissiblefun(1,i) = diff(@(x)admissiblefun(1,i),x);
end 
end 

