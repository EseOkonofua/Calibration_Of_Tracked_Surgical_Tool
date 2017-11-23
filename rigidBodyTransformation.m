%rigidBodyTransformation
%This function calculates the rigid body transformation function.
%Input: 6 fiducial markers
%Output: rotation and translation matrix to get to new coordinate system.
function [rotation, translation] = rigidBodyTransformation(Pos1a, Pos1b, Pos1c, Pos2a, Pos2b, Pos2c)

    A=[Pos1a.';Pos1b.';Pos1c.'];
    B=[Pos2a.';Pos2b.';Pos2c.'];

    %find center
    centreA = mean(A);
    centreB = mean(B);

    N = size(A,1);

    H = (A - repmat(centreA, N, 1))' * (B - repmat(centreB, N, 1));

    [U,S,V] = svd(H);

    rotation = V*U';

    if det(rotation) < 0
        %printf("Reflection detected\n");
        V(:,3) = V(:,3)*(-1);
        rotation = V*U';
    end

    translation = round((-rotation*centreA' + centreB'),10);

    %Code from this function was sourced from: http://nghiaho.com/uploads/code/rigid_transform_3D.m

end