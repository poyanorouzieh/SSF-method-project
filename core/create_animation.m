function create_animation(finalMatrix, xVec, filename)
    if nargin < 3
        filename = 'animation.mp4';
    end
    
    [filepath, ~, ~] = fileparts(filename);
    if ~isempty(filepath) && ~exist(filepath, 'dir')
        mkdir(filepath);  % ???? ?? ????
        fprintf('--> Directory "%s" was created.\n', filepath);
    end
    
    x = xVec(:);
    [N, Nt] = size(finalMatrix);
    
    if length(x) ~= N
        error('Length of position vector (%d) does not match number of matrix rows (%d)!', length(x), N);
    end
    
    % Handling complex numbers
    if ~isreal(finalMatrix)
        disp('Complex matrix detected. The magnitude squared |psi|^2 (density) will be used for plotting.');
        data = abs(finalMatrix).^2;
    else
        data = finalMatrix;
    end
    
    % *** Corrective part: Valid data check ***
    % Remove Inf and NaN values from calculations
    validData = data(isfinite(data(:))); 
    if isempty(validData)
        error(['? All your data contains NaN or Inf! ' ...
               'The SSFM simulation has blown up. Make the time step (dt) much smaller.']);
    end
    
    % Calculate maxY only from valid data
    maxY = max(validData) * 1.1;
    if maxY <= 0
        maxY = 1;  % If all data were zero
    end
    
    % Video setup
    v = VideoWriter(filename, 'MPEG-4');
    v.FrameRate = 2;  
    open(v);
    
    figure('Position', [100, 100, 900, 600], 'Color', 'white');
    hold on;
    grid on;
    
    xlim([min(x),max(x)]);
    ylim([0, maxY]);
    
    % Plot the first frame
    h_plot = plot(x, data(:, 1), 'b-', 'LineWidth', 2.5);
    xlabel('Position (x)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Function value', 'FontSize', 12, 'FontWeight', 'bold');
    title(sprintf('Time evolution - Step: 1 of %d', Nt), 'FontSize', 14);
    drawnow;
    
    % Main loop
    for t = 1:Nt
        set(h_plot, 'YData', data(:, t));
        title(sprintf('Time evolution - Step: %d of %d', t, Nt), 'FontSize', 14);
        drawnow;
        
        frame = getframe(gcf);
        writeVideo(v, frame);
        pause(0.01);
    end
    
    close(v);
    close(gcf);
    fprintf('--> Video successfully saved to file "%s".\n', filename);
end
