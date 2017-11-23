% Author: Eseoghene Okonofua <EseO@Eseoghenes-MacBook-Pro.local>
% Created: 2017-09-25

%Helper function get random point on a sphere surface with given centre and radius
function [coordinates, phi, theta] = GetRandomPointOnSphere(centre, radius, hemisphere)
  % default
  theta = 2*pi*rand; % 0 and 2pi
 % phi = acos(2*rand - 1); 
  phi = pi*rand; % 0 and pi

  if strcmp(hemisphere, 'north')
    %phi = acos(rand);
    phi = (pi/2) * rand;
  elseif strcmp(hemisphere, 'south')
    phi = acos(rand - 1);
  end
  
  x = centre(1) + ( radius * sin(phi) * cos(theta) );
  y = centre(2) + ( radius * sin(phi) * sin(theta) );
  z = centre(3) + ( radius * cos(phi) );
     
  coordinates = [x;y;z];
end
