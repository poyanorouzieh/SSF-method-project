function psi_function = guass_wave_paket(mass,side,mu,lenght)
% an wave paket with sigma , mu and velocity
% ready to use
% mu in [m]
% sigma in [m]
% mass in [Me]
% dt : time step in [s]

%% const table 
hbar = 1.054571817e-34;
sigma = 1e-9;
L = 1e-9;
mass = (mass) *  9.1093e-31;


%% have velocity
dt = 5.427361038484019e-16;
dx = 0.5*L;
velocity = dx / dt;
k0 = mass*velocity / hbar;

%% norm factor
g = @(x) exp(-(x - mu).^2 ./ (2 * sigma^2));
norm_factor = sqrt(integral(@(x) g(x).^2, mu - 100*sigma,mu + 100*sigma, 'AbsTol', 1e-12, 'RelTol', 1e-12));

%% direction of movement
if side == "R" 
    psi_function = @(x) g(x) ./ norm_factor .* exp(1i * k0 .* (x - mu));
elseif side == "L"
    psi_function = @(x) g(x) ./ norm_factor .* exp(-1i * k0 .* (x - mu));
elseif side == "S"
    psi_function = @(x) g(x) ./ norm_factor;
end

end
