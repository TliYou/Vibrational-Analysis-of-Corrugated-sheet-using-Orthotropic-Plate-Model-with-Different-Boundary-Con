%% ES646:ELASTODYNAMICS AND VIBRATIONS Project 
% Rahul Jangid
%%=====================CODE STARTS HERE=====================%%
%%============Main Code START(elastomaincode.m)=================%%
clc; clear all;
%% 0. General specifications
Ngp = 2; %number of quadrature points (2 x 2 for 2d)
%% 1. Geometry specifications
nLines = 60;
PointsPerLine = 60;
%% 2. Create a mesh for the specified domain
[NNodes, NElems, NodalCoords, Fixity, Force, ElemNodes]=grid1(nLines,PointsPerLine,2);
%% 3. Specification of properties of Steel
mu = 0.3;    %Poisson's Ratio  
E  = 200; % Modulus of Elasticity in GPa
rho = 7850; % Density of Steel in kg/m^3
my_coeff = elasticity(mu,E);
my_body_force = @body_force;
%% 4. Compute K, M and F for the system in assembled form
[Kg, Fg, Mg] = createGlobalMatrices(NNodes, NElems, NodalCoords,...
           ElemNodes, my_coeff, my_body_force, Ngp, rho);
%% 5. Application of boundary conditions
% Neumann conditions
for n=1:NNodes
    Fg(2*n-1,1) = Fg(2*n-1,1)+Force(1,n);
    Fg(2*n,1) = Fg(2*n,1)+Force(2,n);
end
% Calculating Active Degrees of freedom
r=0;
for dir=1:NNodes
        if Fixity(1,dir)==1
            r= r+1;
          fixeddof(r) = 2*dir-1;
          r=r+1;
          fixeddof(r) = 2*dir;
        end
end
Ndof = 2*NNodes;
activedof = setdiff([1:Ndof]',[fixeddof]);
%% 6. Solve for Modeshapes and frequency
numberofmodes = 8;
[Modeshape, Freq] = eigs(Kg(activedof,activedof),Mg(activedof,activedof),numberofmodes,0);
%% 7. Contour
%% 7. Contour
for k = 1:numberofmodes
    h=0;
    for i =1:NNodes
        if Fixity(1,i)== 1
            u=0;
            v=0;
        else 
        h=h+1;
            u = Modeshape(2*h-1,k);
            v = Modeshape(2*h,k);
        end 
        M(1,i)=sqrt(u^2+v^2);
    end 
     W = reshape(M,60,60)';  
     Mcon =zeros(size(W));
for r=1:size(W,1)
  Mcon(r,:)=  W(end+1-r,:);
end 
figure(k+9)
 %% Contour for kth frequency '
 contourf(Mcon(:,:));
 colorbar
end
% %%============Main Code END(elastomaincode.m)=================%%