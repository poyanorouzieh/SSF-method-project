function potential_function = Kolon_potential(lenght)

    %% constant table 
    E = 1.546242421785093e-20; % --> energy of free guass wave pack
    
    eta = 0.1 ; % --> the final energy of the interval is eta times the 
               % energy of the free particle
    
    C = eta*E*lenght;
    
    %% potential function
    potential_function = @(x,t) C ./ sqrt(x.^2 + (lenght/1e5)^2);

end