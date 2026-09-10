function potential_function = Wall_potential(a,b,L,V0)

% a in [m]
% b in [m]

%% constant table 
w = 2 / (0.01*L);

%% potential function 
potential_function = @(x,t) (V0/2)*(2+tanh(-w*(x-a))+tanh(w*(x-b)));
end