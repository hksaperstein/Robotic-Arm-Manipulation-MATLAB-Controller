function void = pose(q)

%in mm
L1 = 135;
L2 = 175;
L3 = 169.28

angleConversion = 360 / 4096 %degrees / ticks
q = q*angleConversion;
angle1 = q(2) - 90;
baseAngle = q(1);
angle2 = (q(2)+q(3)) - 180;

joint2X = L2*cos(angle1);
joint2Z = L2*sin(angle1);
joint2Y = joint2X*sin(baseAngle);

endPointX = L3*sin(angle2);
endPointZ = L3*cos(angle2);
endPointY = (joint2X + endPointX)*sin(baseAngle);

figure()
hold on;
grid on;
view(3);

xpoints = [0; 0; joint2X; endPointX];
ypoints = [0; 0; joint2Y; endPointY];
zpoints = [0; L1; joint2Z; endPointZ];

R.handle = plot3(xpoints, ypoints, zpoints);

end