function [ jaco] = jacob0(q)

B = 175;
C = 169.28;
jaco = ...    
[1.0*C*sind(q(3) - 90)*sind(q(1))*sind(q(2)) - 1.0*B*cosd(q(2))*sind(q(1)) - C*cosd(q(3) - 90)*cosd(q(2))*sind(q(1)),   - 1.0*B*cosd(q(1))*sind(q(2)) - C*cosd(q(3) - 90)*cosd(q(1))*sind(q(2)) - 1.0*C*sind(q(3) - 90)*cosd(q(1))*cosd(q(2)), -1.0*C*cosd(q(3) - 90)*cosd(q(1))*sind(q(2)) - 1.0*C*sind(q(3) - 90)*cosd(q(1))*cosd(q(2));
 1.0*C*sind(q(3) - 90)*cosd(q(1))*sind(q(2)) - 1.0*B*cosd(q(1))*cosd(q(2)) - 1.0*C*cosd(q(3) - 90)*cosd(q(1))*cosd(q(2)), 1.0*B*sind(q(1))*sind(q(2)) + 1.0*C*cosd(q(3) - 90)*sind(q(1))*sind(q(2)) + 1.0*C*sind(q(3) - 90)*cosd(q(2))*sind(q(1)), 1.0*C*cosd(q(3) - 90)*sind(q(1))*sind(q(2)) + 1.0*C*sind(q(3) - 90)*cosd(q(2))*sind(q(1));
 0, 1.0*B*cosd(q(2)) + 1.0*C*cosd(q(3) - 90)*cosd(q(2)) - 1.0*C*sind(q(3) - 90)*sind(q(2)), 1.0*C*cosd(q(3) - 90)*cosd(q(2)) - 1.0*C*sind(q(3) - 90)*sind(q(2));
 0, -1.0*sind(q(1)), -1.0*sind(q(1));
 0, -1.0*cosd(q(1)), -1.0*cosd(q(1));
 1, 0, 0];


end

