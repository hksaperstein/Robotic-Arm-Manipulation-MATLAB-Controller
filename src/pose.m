function void = pose(q)

%in mm
L1 = 135;
L2 = 175;
L3 = 169.28;

alpha1 = -pi/2;
alpha2 = 0;
alpha3 = 0;

angleConversion = 360 / 4096; %degrees / ticks
radConversion = pi/180;
q = q * angleConversion * radConversion;
dh1 = dhTransform(L1, 0, q(1), alpha1);
dh2 = dhTransform(0, L2, q(2), alpha2);
dh3 = dhTransform(0, L3, q(3) + pi/2, alpha3);
dh01 = dh1;
dh02 = dh1*dh2;
dh03 = dh02*dh3;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold on;
grid on;
          %base t01, t02, t03
xpoints = [0; dh01(1,4); dh02(1,4); dh03(1,4)];
ypoints = [0; dh01(2,4); dh02(2,4); dh03(2,4)];
zpoints = [0; dh01(3,4); dh02(3,4); dh03(3,4)];

%hold(axes1,'on');
R.handle = plot3(xpoints, ypoints, zpoints,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0],...
    'Marker','pentagram');
xlim(axes1,[-100 400]);
ylim(axes1,[-250 250]);
zlim(axes1,[-100 400]);
view(axes1,[-107.9 4.4]);

end