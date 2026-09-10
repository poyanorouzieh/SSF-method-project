clear; clc; close all;

%% add path
fullPath = mfilename('fullpath');
currentFolder = fileparts(fullPath);
addpath(genpath(currentFolder));

%%  GUI

disp("---------------------------------------------------")
disp("|                     starting                    |")
disp("---------------------------------------------------")
disp(" name : Quantum simulator                          ")
disp(" date : summer 1404                                ")
disp(" Contact me if you find any problem                ")
disp(" gmail : Pa.norouzieh@gmail.com                    ")
disp("---------------------------------------------------")


%% const table
number_of_time_step = 1500;
number_of_x_step = 5000;

e_charge = 1.602e-19;
L = 1e-9;

region_lenght = 1000*L;
mass = 1;

dx = region_lenght / number_of_x_step;
x = (0:number_of_x_step-1)*dx;
V0 = 100 * e_charge ;
mu = region_lenght*0.3;

%% psi function at ground zero
psi_function = guass_wave_paket(mass,"S",mu,region_lenght);
%psi_function = const_wave_paket(mass,"R",45e-9,55e-9);

%% potential function
%potential_function = Harmonic_potential(mass,mu);
%potential_function = BreathingHarmonic(mass, mu, 9);
%potential_function = Wall_potential(30e-9,55e-9,L,V0);
%potential_function = PulsePotential(mass);
%potential_function = const_potential(0);
%potential_function = ocilator_wall(region_lenght,35e-9,65e-9);
%potential_function = Kolon_potential(region_lenght);
potential_function = guass_potential(mu);

%% calculate the psi function evluated by time
[M,T,V] = SSFM(mass,psi_function,potential_function...
    ,region_lenght,number_of_time_step,number_of_x_step);

%% grap data
graph__init__(M,T,V,x,dx);
