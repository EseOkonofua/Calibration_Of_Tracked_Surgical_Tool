% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

function Vm = Drill_Axis_Calibrator(A, B, C)
    % This function computes the calibration process for the drill axis
    % This function will abort with an error message if the input data is
    % illegal.

    [n, m] = size(A); 
    
    % Find the normal by using points from each circle to define a plane 
    % Use plane fitting to fit the points to a plane and get the normal 
    [n1, ~, ~] = affine_fit(A');
    [n2, ~, ~] = affine_fit(B');
    [n3, ~, ~] = affine_fit(C');
    
    normals = [n1 n2 n3];
    % Get Vt as the average of the normals, and get orthonormal coordinate
    % system for the final transformation 
    Vt = mean(normals, 2);
    
    % Convert to marker coordinates 
    % Array of all marker axis values 
    axisVals = zeros(n, m); 
    for i=1:n
		point1 = A(:, i);
        point2 = B(:, i);
        point3 = C(:, i);
        
        [~, ~, ~, c] = Orthonormal_Coordinate_System(point1, point2, point3);
    	[rotation, translation] = rigidBodyTransformation(point1, point2, point3, point1 - c, point2 - c, point3 - c);
        
        % get the marker axis values using Ri-1(P – ti)
        axisVals(:, i) = rotation * (Vt - translation); 
    end 
    
    % Average out axis values to get vm 
    Vm = mean(axisVals, 2); 
    % normalize 
    Vm = round((Vm / norm(Vm)), 4);
end

