clc; clear;

%% part d:

syms alpha1 alpha2 alpha3 theta1 theta2 theta3 A B C
disp('Part D');
transform1 = dhTransform(A, 0, theta1, alpha1)
transform2 = dhTransform(0, B, theta2, alpha2)
transform3 = dhTransform(0, C, theta3, alpha3)

%% part e;
disp('Part E');
transform4 = transform1*transform2*transform3;
pretty (transform4)

%% part f

disp('Part F');
radConvert = pi/180;
theta1 = 45; theta2 = 30; theta3 = -30;
A = 30; B = 20; C = 20;
alpha1 = pi/2; alpha2 = 0; alpha3 = 0;

transform1 = dhTransform(A, 0, theta1 + (pi/2), alpha1)
transform2 = dhTransform(0, B, theta2, alpha2)
transform3 = dhTransform(0, C, theta3, alpha3)

