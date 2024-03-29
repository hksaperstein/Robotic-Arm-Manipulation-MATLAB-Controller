%% Forward Velocity
figure1 = figure;
hold on;
grid on;
view(3);
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

coordPos = [[175 0 -34.28]; [147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]; [175 0 -34.28]];
startTime = tic;
start1x = coordPos(1, 1);
start1y = coordPos(1, 2);
start1z = coordPos(1, 3);

totalTime = [1.5 3 2.5 3 3.5];
totalSteps = [15 30 25 30 50];
graphTime = tic;
trajPoints = quinticTrajectoryPoints(totalTime, totalSteps, coordPos);
[m,n] = size(trajPoints);
    for i = 1:m
        pid_packet(1) = trajPoints(i,1);
        pid_packet(4) = trajPoints(i,2);
        pid_packet(7) = trajPoints(i,3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        jacobian = jacob0([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        velocities = forwardVelKin(jacobian, [return_pid_packet(2) return_pid_packet(5) return_pid_packet(8)]);
        velocities = velocities' / 2500;
        time = toc(startTime);
        
        %addpoints(path, double (points(1,4)), double (points(2,4)), double (points(3,4)));
        %dlmwrite('jointxyzData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1, 4) points(3, 4) points(2, 4) time], 'delimiter',',','-append');
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        quiver3(points(1,4), points(2,4), points(3,4), velocities(1), velocities(2), velocities(3), 'MaxHeadSize', 200);
        drawnow();
    end
%csvPlot('csv/jointxyzData.csv');
grid on;
view(3);
axis([-0 400 -400 400 -50 450]);
xlabel({'X Position (mm)'});clear
zlabel({'Z Position (mm)'});
ylabel({'Y Position (mm)'});
title({'3D Stick Plot of Arm'});
points = pose([0 0 0]);
R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
                
points = pose([0 0 0]);
points = double (points);
path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');

coordPos = [[175 0 -34.28]; [147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]; [175 0 -34.28]];
startTime = tic;
start1x = coordPos(1, 1);
start1y = coordPos(1, 2);
start1z = coordPos(1, 3);

totalTime = [1.5 3 2.5 3 3.5];
totalSteps = [15 30 25 30 50];
graphTime = tic;
trajPoints = quinticTrajectoryPoints(totalTime, totalSteps, coordPos);
[m,n] = size(trajPoints);
    for i = 1:m
        pid_packet(1) = trajPoints(i,1);
        pid_packet(4) = trajPoints(i,2);
        pid_packet(7) = trajPoints(i,3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        jacobian = jacob0([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        velocities = forwardVelKin(jacobian, [return_pid_packet(2) return_pid_packet(5) return_pid_packet(8)]);
        velocities = velocities' / 2500;
        time = toc(startTime);
        
        %addpoints(path, double (points(1,4)), double (points(2,4)), double (points(3,4)));
        %dlmwrite('jointxyzData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1, 4) points(3, 4) points(2, 4) time], 'delimiter',',','-append');
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        quiver3(points(1,4), points(2,4), points(3,4), velocities(1), velocities(2), velocities(3), 'MaxHeadSize', 200);
        drawnow();
    end
%csvPlot('csv/jointxyzData.csv');