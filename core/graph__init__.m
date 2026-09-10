function graph__init__(M,T,V,x,dx)
%%constant table 
e_charge = 1.602e-19;
L = 1e-9;

%% all graph
figure(1);
%% graph the integral on psi^2 most be 1 ...
norm = sum(M,1)*dx;
subplot(2,2,1);
plot(norm)
xlabel('time step');
ylabel('norm in time');
title(' sum(|psi|^2 * dx) ');
grid on;

%% garph average x in wave pack most be linear by time
avgX = (x*M)*dx;
subplot(2,2,2);

plot(avgX ./ L)
xlabel('time step');
ylabel('avrage x in time <x>');
title(' <x> (nm) ');
grid on;

%% graph kinetic
subplot(2,2,3);
plot(T ./ e_charge)
hold on;
xlabel('time step');
ylabel('energy');
title(' <V>  (eV) ');
plot(V ./ e_charge)
hold off;
grid on;
legend('Kinetic', 'Potential');

%% graph hamiltony
subplot(2,2,4);
H = T + V ; 
plot(H ./ e_charge);
xlabel('time step');
ylabel('energy');
title(' <T> (eV) ');
grid on;

end