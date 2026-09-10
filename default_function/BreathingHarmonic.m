function potential = BreathingHarmonic(mass, mu, delta)
    % idk

    %% const table 
    mass = (mass) *  9.1093e-31;
    omega0 = 5e13;
    dt = 5.427361038484019e-16;
    tau = 5e2*dt;
    
    
    %% potential function 
    omega_t = @(t) omega0 + delta*omega0* exp(-((t).^2) / (2 * tau^2));
    potential = @(x, t) 0.5 * mass * (omega_t(t) * (x - mu)).^2;
end