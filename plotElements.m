%%=========Plotting Elements START(plotElements.m)===============%%
function plotElements(ElemNodes,NodalMatrix,NumberOn)
if nargin < 3
	NumberOn = 0;
end
NElems = size(ElemNodes,2);
xx = zeros(4,1);
yy = zeros(4,1);
for i=1:NElems
	for j=1:4
		xx(j) = NodalMatrix(1,ElemNodes(j,i));
		yy(j) = NodalMatrix(2,ElemNodes(j,i));
	end
	x = mean(xx);
	y = mean(yy);
	hold on
	line([xx(1);xx(2)],[yy(1);yy(2)],'color',[0 0 0])
	line([xx(2);xx(3)],[yy(2);yy(3)],'color',[0 0 0])
	line([xx(4);xx(3)],[yy(4);yy(3)],'color',[0 0 0])
	line([xx(1);xx(4)],[yy(1);yy(4)],'color',[0 0 0])
	if NumberOn
		text(x,y,num2str(i),'color','red')
	end
end
%%=========Plotting Elements END(plotElements.m)===============%%