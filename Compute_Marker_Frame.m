% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-11-21

function [ctr, x, y, z] = Compute_Marker_Frame(A,B,C)
%COMPUTER_MARKER_FRAME finds the Marker frame coordinate system
    [x, y, z, ctr] = Orthornomal_Coordinate_System(A,B,C);    
end

