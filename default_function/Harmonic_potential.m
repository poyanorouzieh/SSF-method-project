function potential_function = Harmonic_potential(mass,mu,t)

% harmonic_potential (independent of time )
% mass in [Me]
% mu in [m]

%% const table 
mass = (mass) *  9.1093e-31;
omega = 5e13;

%% potential
potential_function = @(x,t) 1/2 * mass * (omega * (x - mu)).^2; 

end