%%============Grid START(grid.m)===============%%
function [NNodes, NElems, NodalCoords, Fixity, Force, ElemNodes] = grid1(nLines,PointsPerLine,a)
%% Geometry Specification of the equivalent orthopic plate
xMax = 0.832;       % Length across corrugation in meter
yMax = 1;           % length along corrugation (width) in meter
r = 0;
%% Assigning coordinates to every node
NNodes = PointsPerLine*nLines;
NodalMatrix = zeros(3,NNodes);
% initialize returnable stuff for nodes
NodalCoords = zeros(2,NNodes);
Fixity = zeros(2,NNodes);
Force = zeros(2,NNodes);
n = 1;
for i=1:nLines
	StartLen = r;
    EndLenx = xMax;
    EndLeny = yMax;
	ppx = linspace(StartLen,EndLenx,PointsPerLine);
    ppy = linspace(StartLen,EndLeny,nLines);
	for j=1:PointsPerLine
		x = ppx(j);
		y = ppy(i);
		NodalMatrix(1,n) = x;
		NodalMatrix(2,n) = y;
		NodalMatrix(3,n) = n;
		n = n+1;
	end
end
%% element numbering
nElemsPerLinex = PointsPerLine - 1;
nElemsPerLiney = nLines - 1;
NElems = nElemsPerLinex*nElemsPerLiney;
ElemNodePoints = zeros(5,NElems);
ElemNodes = zeros(4,NElems);
n = 1;
for i=1:nElemsPerLiney
	for j=1:nElemsPerLinex
		ElemNodePoints(1,n) = (i-1)*PointsPerLine + j;
		ElemNodePoints(2,n) = ElemNodePoints(1,n)+1;
		ElemNodePoints(3,n) = ElemNodePoints(2,n)+PointsPerLine;
		ElemNodePoints(4,n) = ElemNodePoints(1,n)+PointsPerLine;
		ElemNodePoints(5,n) = n;
		n = n+1;
	end
end
%% set the returnables
NodalCoords = NodalMatrix(1:2,:);
ElemNodes = ElemNodePoints(1:4,:);
%% Boundary Conditions 
switch a 
    %% Fixing the of all end
    case 1 
for i=1:NNodes
	if norm(NodalCoords(1,i)) == 0 || norm(NodalCoords(1,i)-xMax) == 0 || norm(NodalCoords(2,i)-yMax) == 0 || norm(NodalCoords(2,i)) == 0
		Fixity(1,i) = 1;
		Fixity(2,i) = 1;
	end
end
%% left end free and others are fixed
 case 2
for i=1:NNodes
    if norm(NodalCoords(1,i)) == 0 || norm(NodalCoords(2,i)-yMax) == 0 || norm(NodalCoords(2,i)) == 0
		Fixity(1,i) = 1;
		Fixity(2,i) = 1;
    end
end
%% left and Upper end free and other twoend are fixed
 case 3 
for i=1:NNodes
	if norm(NodalCoords(1,i)) == 0 || norm(NodalCoords(2,i)) == 0
		Fixity(1,i) = 1;
		Fixity(2,i) = 1;
	end
end
%% Fixing the right and left end
 case 4
    for i=1:NNodes
	if norm(NodalCoords(1,i)) == 0 || norm(NodalCoords(1,i)-xMax) == 0 
		Fixity(1,i) = 1;
		Fixity(2,i) = 1;
	end
    end
end 
plotNodes(NodalCoords,Fixity,Force,0)
plotElements(ElemNodes,NodalCoords,0)
%%============Grid END(grid.m)===============%%