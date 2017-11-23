% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

%% Test drill axis calibration by generating n points. Finding the Vm and Displaying the angle between ground truth.
n = 20;
range = 2*pi;

iA = [5; 0; 20];
iB = [11; 0; 20];
iC = [5; 0 ; 26];

%Simulate poses
[A, B, C] = Drill_Axis_Simulator(n, iA, iB, iC, [0;0;0], range);

figure
hold on
xlabel('x')
ylabel('y')
zlabel('z')
scatter3(0,0,0)

%Plot
for i = 1:n
   fill3([A(1, i) B(1, i) C(1, i)],  [A(2, i) B(2, i) C(2, i)], [A(3, i) B(3, i) C(3, i)], [0; 0.5; 0])
end

%Vm and angle between Ground Truth
Vm = Drill_Axis_Calibrator(A, B, C)
AngleDifference = atan2d(norm(cross(Vm, [0;0;1])), dot(Vm, [0;0;1]))
hold off