function potential_function = guass_potential(mu)
%% final test for SSFM


%% constant table
L = 1e-9;
dx = 1*L;
dt = 5.427361038484019e-16;
sigma = 10*L;
v0 = dx/dt;
e_charge = 1.602e-19;
V0 = 1e3* e_charge;

%% potential function
v = @(t) v0*(1 - exp(- t ./ (21.7147*dt)));
potential_function = @(x, t) -V0 * exp(- (x - (mu + v(t) * t)).^2 / (2 * sigma^2));

end