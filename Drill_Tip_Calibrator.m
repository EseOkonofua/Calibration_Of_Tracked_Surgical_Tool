% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

function Tm = Drill_Tip_Calibrator(A, B, C)
%Drill_Tip_Calibrator Finds the tip of a drill Tip in Marker coordinates
%given coordinates in numerous poses.

    [~, cols] = size(A);
    
    %Fit each set of fiducials to their corresponding sphere 
    [CentreA, ~] = Sphere_Fit(A');
    [CentreB, ~] = Sphere_Fit(B');
    [CentreC, ~] = Sphere_Fit(C');
    
    % Find the average centre to get the pivot point in the tracker frame.
    Tt = round(mean([CentreA, CentreB, CentreC], 2), 4);
    pC = zeros(3, cols);
    
    %Get base Marker frame
    [x1, y1, z1, c1] = Orthonormal_Coordinate_System(A(:, 1), B(:, 1), C(:, 1));
        
    for i = 1:cols
        %Get the coordinate system for the markers at pose i
        [x2, y2, z2, ~] = Orthonormal_Coordinate_System(A(:, i), B(:, i), C(:, i));
        
        %Use the rigid body transform to find translation matrix
        [~, translation] = rigidBodyTransformation(A(:, i), B(:, i), C(:, i), A(:, i) - c1 , B(:, i) - c1, C(:,i) - c1);
        
        %Generate rotation matrix to base coordinate frame
         rotation_mat = ...
            [dot(x1,x2), dot(x1,y2), dot(x1, z2), 0;...
            dot(y1,x2), dot(y1,y2), dot(y1, z2), 0;... 
            dot(z1,x2), dot(z1,y2), dot(z1, z2), 0;...
            0,0,0,1];
        
        %Homeogeneous translation matrix
        t = eye(4);
        t(1:3, 4) = translation;

        %apply rotation and translation
        val = t*rotation_mat*[Tt; 1];
        
        pC(:, i) = val(1:3);
    end

    %take average of all poses to find Tm
    Tm = mean(pC, 2);  
end

