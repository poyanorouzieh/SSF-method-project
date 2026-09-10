function psi_function = const_wave_paket(mass,side,a,b)
% an const wave function in range a , b 
% a in [m]
% b in [m]
% m in [Me]
% side is "R" of "L"

%% tabel
mass = (mass) *  9.1093e-31;

%% velocity  ( test )
hbar = 1.054571817e-34;
mu = a+b/2;
L = 1e-9;
dt = 5.427361038484019e-16; % --> it most be  atomat
dx = 0.1*L;                 %--> it mean 0.1 nm pear step time
velocity = dx / dt;
k0 = mass*velocity / hbar;

%% psi function
psi_function = @(x) (x >= a & x <= b) ./ sqrt(b-a);

%% direction of movement
if side == "R" 
    psi_function = @(x) psi_function(x) .* exp(1i * k0 .* (x - mu));
elseif side == "L"
    psi_function = @(x) psi_function(x) .* exp(-1i * k0 .* (x - mu));
else
    psi_function = @(x) psi_function(x);

end