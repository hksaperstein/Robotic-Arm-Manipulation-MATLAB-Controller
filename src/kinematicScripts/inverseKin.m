%% inverse kinematics
figure1 = figure;
hold on;
grid on;
axis([-150 350 -250 250 -100 400]);
points = pose([0 0 0]);
xlabel({'X Position (mm)'});
zlabel({'Z Position (mm)'});
ylabel({'Y Position (mm)'});
title({'3D Stick Plot of Arm'});
R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
                    'Marker','o',...
                    'Color',[0 1 0]);


pos1 = ikin([175,0,-34.28])
pos2 = ikin([0,-344.28,135])

pid_packet(1) = pos2(1);
pid_packet(3504) = pos2(2);
pp.write(PID_ID, pid_packet);
pid_packet(7) = pos2(3);
pp.write(PID_ID, pid_packet);

points = pose([pid_packet(1) pid_packet(4) pid_packet(7)]);
set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
drawnow();
pause(5);
pid_packet(1) = pos1(1);
pid_packet(4) = pos1(2);
pp.write(PID_ID, pid_packet);
pid_packet(7) = pos1(3);
pp.write(PID_ID, pid_packet);

points = pose([pid_packet(1) pid_packet(4) pid_packet(7)]);
set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
drawnow();
