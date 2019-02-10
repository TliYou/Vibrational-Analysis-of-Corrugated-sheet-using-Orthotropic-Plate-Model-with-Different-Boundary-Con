%%============Elasticity START(elasticity.m)===============%%
function my_coeff = elasticity(mu,E);
%% Dimensions of corrugated sheet
c = 52*10^(-3);     
l = 57*10^(-3);     
t = 1*10^(-3);      
%% Formulation of Elasticity matrix
I_y = 100579.5752*10^(-12);   % Area Moment of Inertia about y-axis
D_x = (c*E*t^3)/(12*l);
D_y = (E*I_y)/c;
D_xy = (l*E*t^3)/(6*c*(1+mu));
mu_xy = (D_x*mu)/D_y;
mu_yx = mu;
%% Equivalent Rigidities
E_x = (12*(1-(mu_xy*mu_yx))*D_x)/t^3;
E_y = (12*(1-(mu_xy*mu_yx))*D_y)/t^3;
G_xy = (6*D_xy)/t^3;
%% Elasticity matrix for Plane Stress Condition
my_coeff = (1/(1-(mu_xy*mu_yx)))*   [E_x, mu_yx*E_x, 0;...
                                    mu_xy*E_y, E_y, 0;...
                                    0, 0, (1-(mu_xy*mu_yx))*G_xy];
end
%%============Elasticity END(elasticity.m)===============%%