function [ jaco] = jacob0(q)
% syms A B C q(1) q(2) q(3)
% pie = sym(pi)                                                                             
% 
% 
% 
% 
% dh01 = dhTransform(A, 0, -q(1), pie/2)
% dh12 = dhTransform(0, B, q(2), 0)
% dh23 = dhTransform(0, C, q(3)-pie/2, 0)
% 
% dh02 = dh01 * dh12
% dh03 = dh02 * dh23
% 
% 
% 
% jaco = [diff(dh03(1:3,4),q(1)) diff(dh03(1:3,4),q(2)) diff(dh03(1:3,4),q(3));
%         [0;0;1] dh01(1:3,3) dh02(1:3,3)]
%

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

