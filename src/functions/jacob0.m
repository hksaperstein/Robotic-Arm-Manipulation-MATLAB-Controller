function [ jaco] = jacob0(q)

B = 175;
C = 169.28;



jaco = ...
[ -cos(q1(t))*(C*cos(q2(t) + q3(t)) + B*cos(q2(t))),sin(q1(t))*(C*sin(q2(t) + q3(t)) + B*sin(q2(t))), C*sin(q1(t))*sin(q2(t) + q3(t));
 -sin(q1(t))*(C*cos(q2(t) + q3(t)) + B*cos(q2(t))), -cos(q1(t))*(C*sin(q2(t) + q3(t)) + B*sin(q2(t))), -C*cos(q1(t))*sin(q2(t) + q3(t));
 0, C*cos(q2(t) + q3(t)) + B*cos(q2(t)), C*cos(q2(t) + q3(t));
 0, sin(pi/2 + q1(t)), -cos(pi/2 + q1(t))*sin(q2(t));
 0, -cos(pi/2 + q1(t)), -sin(q2(t))*sin(pi/2 + q1(t));
 1, 0, cos(q2(t))];

end

