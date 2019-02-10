%%==Global Matrices Function START(createGlobalMatrices.m)==%%
function [Kg, Fg, Mg] = createGlobalMatrices(NNodes,NElems,NodalCoords,...
                     ElemNodes,my_coeff, my_body_force, Ngp, rho)
%% Inputs:
%  Kg: global system matrix of size (Ndof x Ndof)
%  Fg: global right hand side vector of size (Ndof x 1)
%% Degree of freedom
Ndof = 2*NNodes;
%% Initializations
Kg = zeros(Ndof, Ndof);
Fg = zeros(Ndof, 1);
Mg = zeros(Ndof,Ndof);
[qs, ws] = quad_data(Ngp);
for e = 1:NElems
    %% Assigning nodal numbering and their respective coordinate values
   n1 = ElemNodes(1,e);     %bottom-left node of the element
   n2 = ElemNodes(2,e);     %bottom-right node of the element
   n3 = ElemNodes(3,e);     %top-right node of the element
   n4 = ElemNodes(4,e);     %top-left node of the element
   x1 = NodalCoords(1,n1);  %bottom-left x nodal coordinate of the element
   x2 = NodalCoords(1,n2);  %bottom-right x nodal coordinate of the element
   x3 = NodalCoords(1,n3);  %top-right x nodal coordinate of the element
   x4 = NodalCoords(1,n4);  %top-left x nodal coordinate of the element
   y1 = NodalCoords(2,n1);  %bottom-left y nodal coordinate of the element
   y2 = NodalCoords(2,n2);  %bottom-right y nodal coordinate of the element
   y3 = NodalCoords(2,n3);  %top-right y nodal coordinate of the element 
   y4 = NodalCoords(2,n4);  %top-left y nodal coordinate of the element
   %% Elemental Stiffness, Force and Mass Matrix
   Ke = zeros(8,8);
   Fe = zeros(8,1);
   Me = zeros(8,8);
   for p= 1:Ngp
       for q = 1:Ngp
            xi = qs(q);
            eta = qs(p);
            [N, B, j] = sf_data(x1, x2, x3,x4,y1,y2,y3,y4,eta,xi);
      
             Ke = Ke + (B'*my_coeff*B)*j*ws(q)*ws(p);
             x_at_xieta = N(1,1)*x1 + N(1,3)*x2 + N(1,5)*x3 + N(1,7)*x4;
             y_at_xieta = N(2,2)*y1 + N(2,4)*y2 + N(2,6)*y3 + N(2,8)*y4;
             l = feval(my_body_force, x_at_xieta, y_at_xieta);
             Fe = Fe + N'*l*j*ws(q)*ws(p);
             Me = Me + rho * N' * N * j * ws(q) * ws(p);
       end
   end%q
   %% Assembly of Elemental Stiffness, Force and Mass Matrix to Global Matrices
  Kg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4],[2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])...
      = Kg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4],[2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])+Ke;
  Mg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4],[2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])...
      = Mg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4],[2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])+Me;
  Fg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])...
      = Fg([2*n1-1 2*n1 2*n2-1 2*n2 2*n3-1 2*n3 2*n4-1 2*n4])+Fe;
end%e
%%==Global Matrices Function END(createGlobalMatrices.m)==%%