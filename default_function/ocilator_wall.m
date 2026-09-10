function potential_function = ocilator_wall(lenght,A,B)
% this function its not good at all bec dt and map are 
% not scaled and they are just use for guass wave paket

%% constant table
Amp = 0.1*lenght;
dt = 5.427361038484019e-16;
omega = 2*pi/(100*dt);
e_charge = 1.602e-19;
V0 = 100* e_charge;

%V0 =  1e5*1.546242421785093e-20;

L = 1e-9;
w = 2 / (0.01*L);

if Amp >= (B - A) / 2
    error('The Walls collide');
end

%% potential function
a = @(t) A + Amp*sin(omega*t);
b = @(t) B - Amp*sin(omega*t);
potential_function = @(x, t)(V0/2)*(2+tanh(-w*(x-a(t)))+tanh(w*(x-b(t))));

end