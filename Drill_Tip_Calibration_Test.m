% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

%% Test drill tip calibration by using ideal points. Generate n poses and graph them.
n = 20;

iA = [5; 0; 20];
iB = [11; 0; 20];
iC = [5; 0 ; 26];

%Simulation
[A, B, C] = Drill_Tip_Simulator(n, iA, iB, iC, [0;0;0]);

figure
hold on
xlabel('x')
ylabel('y')
zlabel('z')
scatter3(0,0,0)

%Plotting
for i = 1:n
   fill3([A(1, i) B(1, i) C(1, i)],  [A(2, i) B(2, i) C(2, i)], [A(3, i) B(3, i) C(3, i)], [0; 0.5; 0])
end
hold off

[Tm] = Drill_Tip_Calibrator(A, B, C);
Tm