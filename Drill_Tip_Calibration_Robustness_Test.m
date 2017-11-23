% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

%This file runs the calibration Robustness test
n = 20;

%We plan on generating 10 points with increasing Emax values
Emax = 0.01;

iA = [5; 0; 20];
iB = [11; 0; 20];
iC = [5; 0 ; 26];

%Simulate points to get ground truth
[A, B, C] = Drill_Tip_Simulator(n, iA, iB, iC, [0;0;0]);

%Get the actual ground truth Tm
actualTm = Drill_Tip_Calibrator(A, B, C);
%0.001 is a milimeter

errMat = zeros(1, 10);
errVals = zeros(1, 10);

figure 
hold on
xlabel('Emax')
ylabel('Calibration Error')

xlim([0 0.01])

ind = 1;
%Incrementally add 1mm of Marker tracking error 
for i = 0:0.001:Emax
    newA = zeros(3, n);
    newB = zeros(3, n);
    newC = zeros(3, n);
    
    %Offset the poses by random Emax value
    for j = 1:n
       newA(:, j) = GetRandomPointOnSphere(A(:, j), i, 'all');
       newB(:, j) = GetRandomPointOnSphere(B(:, j), i, 'all');
       newC(:, j) = GetRandomPointOnSphere(C(:, j), i, 'all');
    end
    
    newTm = Drill_Tip_Calibrator(newA, newB, newC);
    
    %Distance between actual Tm and Error prone Tm
    normal = norm(newTm - actualTm);
    
    errMat(ind) = i;
    errVals(ind) = normal;
    ind = ind + 1;
end

%Plot

%Line representing clinical accuracy
clinicallyAcc = linspace(0, 0.1,10);
clinicallyAccY = ones(1, 10)*0.001;

plot(clinicallyAcc, clinicallyAccY)
plot(errMat, errVals)

legend('Clinically Accurate Line', 'Calibration Error')
hold off
