%%=========Plotting Nodes START(plotNodes.m)===============%%
function plotNodes(NodalMatrix,Fixity,Force, NumberOn)
if nargin < 4
	NumberOn = 0;
end
NNodes = size(NodalMatrix,2);
for i=1:NNodes
	hold on
	plot(NodalMatrix(1,i),NodalMatrix(2,i),'.k');
    title('Grid of Equivalent Orthotropic Plate', 'FontSize', 16);
    xlabel('Length across corrugation',  'FontSize', 14);
    ylabel('Length along corrugation', 'FontSize', 14);
	if NumberOn
		text(NodalMatrix(1,i),NodalMatrix(2,i),num2str(i));
	end
	% indicate fixed nodes
	if Fixity(1,i)
		plot(NodalMatrix(1,i),NodalMatrix(2,i),'ok','MarkerFaceColor','k')
	end
	% indicated nodes where forces are applied
	if Force(1,i)
		plot(NodalMatrix(1,i),NodalMatrix(2,i),'>k','MarkerFaceColor','k')
	end
end
%%=========Plotting Nodes END(plotNodes.m)===============%%