function potential_function = PulsePotential(mass)
% an pulse function in force ( like electrical fild )


    %% const table 
    mass = (mass) *  9.1093e-31;
    dt = 5.427361038484019e-16;
    
    %calculate tau
    tau = 65.901022 * dt;
    
    %calculate F0
    eta = 10;
    F0 = ( mass * 10 / (tau) )*sqrt(2/pi)*(1e-10 / dt);
    t0 = 0; 
 
    %% potential function 
    potential_function = @(x, t) -F0 * exp(-((t - t0).^2) / (2 * tau^2)) .* x;
end