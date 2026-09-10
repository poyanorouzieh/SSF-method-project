function potential_function = const_potential(V0)
%% v0 in electron volt
%% const table
e_charge = 1.602e-19;

%% potential function
V0 = V0 * e_charge;  
potential_function = @(x,t) V0 * ones(size(x));

end