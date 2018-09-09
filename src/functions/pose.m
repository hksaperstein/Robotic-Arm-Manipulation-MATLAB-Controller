function [points] = pose(q)

%in mm
L1 = 135;
L2 = 175;
L3 = 169.28;

alpha1 = pi/2;
alpha2 = 0;
alpha3 = pi;
alpha4 = pi/2;

%conversion = pi / 2048; %degrees / ticks
q = q * 360/4096;
q = q * pi/180;

dh1 = dhTransform(L1, 0, -q(1), alpha1);
dh2 = dhTransform(0, L2, q(2), alpha2);
dh3 = dhTransform(0, L3, q(3)-pi/2, alpha3);
dh4 = dhTransform(0, 0, +pi/2, alpha4);

dh01 = dh1;
dh02 = dh1*dh2;
dh03 = dh02*dh3*dh4;

          %base t01, t02, t03
points =  [0 dh01(1,4) dh02(1,4) dh03(1,4);
           0 dh01(2,4) dh02(2,4) dh03(2,4);
           0 dh01(3,4) dh02(3,4) dh03(3,4)];


return