%% Inverse Numeric Simulation
close all; clc; clear all;
figure1 = figure;
hold on;
grid on;

axis([-0 300 -100 300 -50 450]);
xlabel({'X Position (mm)'});
zlabel({'Z Position (mm)'});
ylabel({'Y Position (mm)'});
title({'3D Stick Plot of Arm'});
points = pose([0 0 0]);
R.handle = plot(points(1,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
                
points = pose([0 0 0]);
points = double (points);
%path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');

currentPosition = [175 0 -34.28];
[x,z] = ginput(1);
errorX = 100;
errorZ = 100;
while(errorX > 5 || errorZ > 5)
    
    nextPosition = inverseCalc(currentPosition, [x 0 z]);
    points = pose(nextPosition)
    currentPosition = [points(1, 4) points(2, 4) points(3, 4)]
    
    errorX = abs(x - currentPosition(1))
    errorZ = abs(z - currentPosition(3))
    
    set(R.handle, 'xdata', points(1,:), 'ydata', points(3,:));  
    plot([x, currentPosition(1)], [z, currentPosition(3)])
    drawnow()
end 
%