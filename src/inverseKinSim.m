%% Inverse Numeric Simulation
close all; clc; clear all;
figure1 = figure;
hold on;
grid on;
view([0 0]);
axis([-0 400 -400 400 -50 450]);
xlabel({'X Position (mm)'});
zlabel({'Z Position (mm)'});
ylabel({'Y Position (mm)'});
title({'3D Stick Plot of Arm'});
points = pose([0 0 0]);
R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
                
points = pose([0 0 0]);
points = double (points);
path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');



while(1)
    [point] = ginput3d(1);
    nextPosition = point;
    nextPosition = inverseCalc(nextPosition, point);
    points = pose(nextPosition)
    set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
    drawnow()
end 
%