% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

function [A, B, C] = Drill_Axis_Simulator(n, a, b, c, pivot, range)
    %Generates n poses in full range, for drill axis calibration. a, b, c
    %represent starting positions.
    
    A = zeros(3, n); 
    B = zeros(3, n); 
    C = zeros(3, n); 
    
    % Get radius for each circle based on the starting points 
    radius1 = norm(pivot(1) - a(1));
    radius2 = norm(pivot(1) - b(1));
    radius3 = norm(pivot(1) - c(1)); 
    
    % Get random points on the circumference of the circles spanned by each
    % radii 
    for i=1:n
        % Get a random angle within the calibration range 
        randAngle = range*rand; 
        
        % Pose 1 
        x1 = radius1 * cos(randAngle) + pivot(1); 
        y1 = radius1 * sin(randAngle) + pivot(2); 
        z1 = a(3) + pivot(3); 
        A(:, i) = [x1; y1; z1]; 
        
        % Pose 2
        x2 = radius2 * cos(randAngle) + pivot(1); 
        y2 = radius2 * sin(randAngle) + pivot(2); 
        z2 = b(3) + pivot(3); 
        B(:, i) = [x2; y2; z2]; 
        
        % Pose 3
        x3 = radius3 * cos(randAngle) + pivot(1); 
        y3 = radius3 * sin(randAngle) + pivot(2); 
        z3 = c(3) + pivot(3); 
        C(:, i) = [x3, y3, z3]; 
    end
end

