%%=====Shape Function START(sf_data.m)===========%%
function [N, B,j] = sf_data(x1,x2,x3,x4,y1,y2,y3,y4,eta,xi)
% Computes shape function, its gradient and jacobian of transformation
% Inputs:
%  x1,x2,x3,x4,y1,y2,y3,y4 : nodal coordinates of the element
%  xi, eta : value of \xi and\eta at which data is to be computed
% Outputs:
%  N: 2x8 vector of shape functions
%  B: 3x8 vector of shape function gradients
%  j: determinant of jacobian of transformation
%% Shape function
N = [(1-xi)*(1-eta),0 ,(1+xi)*(1-eta),0, (1+xi)*(1+eta),0,(1-xi)*(1+eta),0;...
    0,(1-xi)*(1-eta),0 ,(1+xi)*(1-eta),0, (1+xi)*(1+eta),0,(1-xi)*(1+eta)]*0.25;
%% Jacobian Matrix
J(1,1) = ( ((1-eta)*(x2-x1)) + ((1+eta)*(x3-x4)) )*0.25;
J(1,2) = ( ((1-xi)*(x4-x1)) + ((1+xi)*(x3-x2)) )*0.25;
J(2,1) = ( ((1-eta)*(y2-y1)) + ((1+eta)*(y3-y4)) )*0.25;
J(2,2) = ( ((1-xi)*(y4-y1)) + ((1+xi)*(y3-y2)) )*0.25;
j=det(J);
%% Calculating B Matrix
sf_der = 0.25*[eta-1, 1-eta, 1+eta, -1-eta;...
                xi-1, -1-xi,  1+xi,  1-xi];
sf_cap = inv(J') * sf_der;
B = zeros(3,8);
for i=1:4
    B(1,2*i-1) = sf_cap(1,i);
    B(2,2*i) = sf_cap(2,i);
    B(3,2*i)= B(1,2*i-1);
    B(3,2*i-1)= B(2,2*i);
end
%%=====Shape Function END(sf_data.m)===========%%