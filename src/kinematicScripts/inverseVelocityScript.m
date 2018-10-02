%% Inverse Velocity
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

coordPos = [[147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]; [175 0 -34.28]];

totalTime = [1.5 3 2.5 3 3.5];
totalSteps = [15 30 25 30 50];
%trajPoints = quinticTrajectoryPoints(totalTime, totalSteps, coordPos);
[m,n] = size(coordPos);
jacobian = jacob0([0 0 0]);
setPt = [0, 0, 0];
startPts  = [0,0,0];
for i = 1:m
    startTime = tic;
    while(toc(startTime) < (totalSteps(i) / totalTime(i)))
        posVector = coordPos(i, :) - startPts(1, :);
        velVector = posVector / (totalTime(i)/totalSteps(i));
        angVel = inverseVelKin(jacobian, velVector);
        setPt = setPt + angVel' * (totalTime(i)/totalSteps(i))
        %pos = ikin(coordPos(i-1, :));
        pid_packet(1) = setPt(1);
        pid_packet(4) = setPt(2);
        pid_packet(7) = setPt(3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        %time = toc(startTime)
        jacobian = jacob0([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        startPts = points(1:3, 4)';
    end
%     velocities = forwardVelKin(jacobian, [return_pid_packet(2) return_pid_packet(5) return_pid_packet(8)]);
%     velocities = velocities';
% 
%     angularVel = inverseVelKin(jacobian,velocities(1:3));
%     angularVel = angularVel'
    %dlmwrite('csv/angularVel.csv', [angularVel(1) angularVel(2) angularVel(3) time], 'delimiter',',','-append');
%     tic
%     while(toc < totalTime(i-1))
%         return_status_packet = getStatus(pp, STATUS_ID, status_packet);
%         points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
%         addpoints(path, double (points(1,4)), double (points(2,4)), double (points(3,4)));
%         set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
%         drawnow();
%     end
    %set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
    %quiver3(points(1,4), points(2,4), points(3,4), velocities(1), velocities(2), velocities(3), 'MaxHeadSize', 200);
    
end
%csvPlot('csv/angularVel.csv');