%%=====Quadrature Points Function START(quad_data.m)===========%%
function [qs, ws] = quad_data(Ngp)
% Gives abscissas (qs) and weights (ws) for gauss quadrature
% Ngp: number of gauss points required
switch Ngp
   case 1
      qs = 0;
      ws = 2;
   case 2
      qs = [-0.577350269189626; 0.577350269189626];
      ws = [1; 1];
    case 3
      qs = [0; 0.774597; -0.774597];
      ws = [0.888889; 0.555556; 0.555556];
   otherwise
      error('Quadrature order not defined')
end
%%=====Quadrature Points Function END(quad_data.m)===========%%