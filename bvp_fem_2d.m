%% ES646:ELASTODYNAMICS AND VIBRATIONS Project 
% Rahul Jangid
%%=====================CODE STARTS HERE=====================%%
%%============Main Code START(bvp_fem_2d.m)=================%%
clc; clear all;
%% 0. General specifications
Ngp = 2; %number of quadrature points (2 x 2 for 2d)
%% 1. Geometry specifications
nLines = 60;
PointsPerLine = 60;
FarStress = 0;
%% 2. Create a mesh for the specified domain
[NNodes, NElems, NodalCoords, Fixity, Force, ElemNodes]=grid1(nLines,PointsPerLine);
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
for k = 1:numberofmodes
    col=1;row=1;h=0;
    %For Modeshape 1
    for i=1:NNodes
         if mod(i,PointsPerLine)==0 ||  mod(i,PointsPerLine)==1
             u=0;
            v=0;
           if i>1
               if mod(i,PointsPerLine)==1
                   row=row+1;
                   col=1;
               end
           end
         else
            h=h+1;
            u = Modeshape(2*h-1,k);
            v = Modeshape(2*h,k);
         end
        M(i) = sqrt(u^2+v^2);
        Mcon(row,col,k) = M(i);
        col=col+1;
    end
end
%% Contour for frequency 0.2344
figure(2)
contourf(Mcon(:,:,1));
colorbar
title('Vibration mode for frequency 0.2344', 'FontSize', 16);
%% Contour for frequency 0.3315
figure(3)
contourf(Mcon(:,:,2));
colorbar
title('Vibration mode for frequency 0.3315', 'FontSize', 16);
%% Contour for frequency 0.4748
figure(4)
contourf(Mcon(:,:,3));
colorbar
title('Vibration mode for frequency 0.4748', 'FontSize', 16);
%% Contour for frequency 1.0644
figure(5)
contourf(Mcon(:,:,4));
colorbar
title('Vibration mode for frequency 1.0644', 'FontSize', 16);
%% Contour for frequency 1.1803
figure(6)
contourf(Mcon(:,:,5));
colorbar
title('Vibration mode for frequency 1.1803', 'FontSize', 16);
%% Contour for frequency 1.4416
figure(7)
contourf(Mcon(:,:,6));
colorbar
title('Vibration mode for frequency 1.4416', 'FontSize', 16);
%% Contour for frequency 1.3268
figure(8)
contourf(Mcon(:,:,7));
colorbar
title('Vibration mode for frequency 1.3268', 'FontSize', 16);
%% Contour for frequency 2.1756
figure(9)
contourf(Mcon(:,:,8));
colorbar
title('Vibration mode for frequency 2.1756', 'FontSize', 16);
%%============Main Code END(bvp_fem_2d.m)=================%%