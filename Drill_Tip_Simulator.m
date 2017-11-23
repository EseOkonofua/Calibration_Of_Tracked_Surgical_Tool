% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

function [A, B, C] = Drill_Tip_Simulator(n, a, b, c, pivot)
%Drill_Tip_Simulator Simulates n poses of pivoting of drill around pivot point
% a, b, c represent our starting marker positions
    
    radiusA = norm(pivot - a);
    radiusB = norm(pivot - b);
    radiusC = norm(pivot - c);
    
    %Initial A Phi and Theta
    phiOldA = acos((a(3) - pivot(3)) / radiusA);
    thetaOldA = 0; %Theta is zero because our initial y positions will be 0
    
    %Initial B Phi and Theta
    phiOldB = acos((b(3) - pivot(3))/radiusB);
    thetaOldB = 0;
    
    %Initial C Phi and Theta
    phiOldC = acos((c(3) - pivot(3))/radiusC);
    thetaOldC = 0;
    
    %Initialize first positions
    A = zeros(3, n);
    A(:, 1) = a;
    
    B = zeros(3, n);
    B(:, 1) = b;
    
    C = zeros(3, n);
    C(:, 1) = c;
    
    %Keep track of triangle side lengths for error removal
    AB = norm(B(:, 1) - A(:, 1));
    AC = norm(C(:, 1) - A(:, 1));

    %Generate poses
    count = 1;
    while count < n
       %Generate new pose for point A
       [newA, phiNew, thetaNew] = GetRandomPointOnSphere(pivot, radiusA, 'north');
        
       %Keep track of the cchange in pose by monitoring spherical coordinate angles
       phiDelta = phiNew - phiOldA;
       thetaDelta = thetaNew - thetaOldA;

       %Apply change in angles to get new position B markers
       changedPhiB = phiOldB + phiDelta;
       changedPhiB = mod(changedPhiB + pi/2, pi) - pi/2;
       changedThetaB = wrapTo2Pi(thetaOldB + thetaDelta);
       
       %Spherical coordinate calculations
       Bx = pivot(1) + (radiusB * sin(changedPhiB) * cos(changedThetaB));
       By = pivot(2) + (radiusB * sin(changedPhiB) * sin( changedThetaB ));
       Bz = pivot(3) + (radiusB * cos(changedPhiB));
       
       newB = [Bx; By; Bz];
       
       changedPhiC = phiOldC + phiDelta;
       changedPhiC = mod(changedPhiC + pi/2, pi) - pi/2;
       changedThetaC = wrapTo2Pi(thetaOldC + thetaDelta);
       Cx = pivot(1) + (radiusC * sin(changedPhiC) * cos(changedThetaC));
       Cy = pivot(2) + (radiusC * sin(changedPhiC) * sin(changedThetaC));
       Cz = pivot(3) + (radiusC * cos(changedPhiC));

       newC = [Cx; Cy; Cz];
        
       %Make sure that triangle sides are accurate then add to pose list
       if norm(newB - newA) == AB && norm(newC - newA) == AC
          count = count + 1;
          A(:, count) = newA;
          B(:, count) = newB;
          C(:, count) = newC;

       end
    end
end

