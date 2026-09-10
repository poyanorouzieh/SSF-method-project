function [finalMatrix,T,V] = SSFM(mass,psi_function ...
    ,potential_function,lenght,N_time_step,n)

%% const table
global hbar
global N
hbar = 1.054571817e-34;
N = n;
mass = mass *  9.1093e-31;

%% calculate step zero and some const vector 
[step_psi,step_potential,k_vector] = vector(lenght,N,psi_function ...
                        ,potential_function,0,0);


                    
dx = lenght / N;
x = (0:N-1)*dx;
dt = step_time(mass,dx,step_potential,step_psi); % --> for ground zero time

finalMatrix = zeros(N, N_time_step);
Kinetic_energy = zeros(1,N_time_step);
Potential_energy = zeros(1,N_time_step);

prob_t = abs(step_psi).^2;
finalMatrix(:,1) = prob_t;
%% calculate first step kinetic Energy
Potential_energy(1) = step_potential*finalMatrix(:,1)*dx;

%% calculate first step kinetic Energy 
psi_k = fft(step_psi);
T_k = (hbar^2 .* k_vector.^2) ./ (2*mass);
Kinetic_energy(1) = (dx^2/lenght)*sum(abs(psi_k).^2 .* T_k);


%% calculate per every step time (main loop)
for time_step = 2:N_time_step
    
    [~,step_potential,~] = vector(lenght,N,psi_function...
    ,potential_function,time_step,dt);
    
    step_psi = forward_in_time(dt, step_psi, step_potential, k_vector, mass);
    
    % Kinetic energy
    psi_k = fft(step_psi);
    
    T_k = (hbar^2 .* k_vector.^2) ./ (2*mass);
    
    Kinetic_energy(time_step) = (dx^2/lenght) * sum(abs(psi_k).^2 .* T_k);
    
    prob_t = abs(step_psi).^2;
    
    % final result
    finalMatrix(:,time_step) = prob_t;
    
    % test 
    
    % Potential Energy
    Potential_energy(time_step) = step_potential * (prob_t.') * dx;
end

%% show the plot animation ( by AI )
try
    create_animation(finalMatrix, x, 'result/result.mp4');
    
catch
    disp("error displaying video");
end

%% send result

% calculate average potential in every step
V = Potential_energy;

% calculate average kinetic energy in every step
T = Kinetic_energy;

disp("---------------------------------------------------")

end

%% sub function 
function [psi_vector,potential_vector,k_vector] = vector(L,N,psi_function...
    ,potential_function,time_step,dt)

lenght = (0:N-1)*(L/N);
psi_vector = psi_function(lenght);
k_vector = (2*pi/L)*[0:N/2-1, -N/2:-1];
potential_vector = potential_function(lenght,(time_step-1)*dt);

end

function step_time = step_time(mass,step_lenght,step_potential,psi_step)

global hbar
global N

lenght = (0:N-1)*step_lenght;

varx = var(lenght,abs(psi_step).^2);

dt_kinetic = 4*pi*mass*varx/hbar;

dt_potential = (2*hbar / max(abs(step_potential)));

f = 1e-2;

step_time = f*dt_kinetic;

disp("dt :")
disp(step_time)

end

function psi_vector = forward_in_time(dt,psi_vector_input,potential_vector,K,mass)

global hbar

% Half potential step
Vphase = exp(-1i*potential_vector*dt/(2*hbar));
psi_vector_input = psi_vector_input .* Vphase;

% Full kinetic step
psi_vector_input = fft(psi_vector_input);

Kphase = exp(-1i*hbar*K.^2*dt/(2*mass));
psi_vector_input = psi_vector_input .* Kphase;

psi_vector_input = ifft(psi_vector_input);

% Half potential step
psi_vector = psi_vector_input .* Vphase;

end
