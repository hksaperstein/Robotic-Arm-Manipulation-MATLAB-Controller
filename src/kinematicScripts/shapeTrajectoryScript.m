%% Quintic Trajectory
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
R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
                    'Marker','o',...
                    'Color',[0 1 0]);

pos1 = ikin([147 120 215]);
pos2 = ikin([194 -147 20]);
pos3 = ikin([135 67 -13]);


points = pose([0 0 0]);
points = double (points);
path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');

coordPos = [[175 0 -34.28]; [175 0 50]; [90 115 250]; [133 0 350]; [175 0 250]; [218 0 325]; [265 75 250]; [175 0 50]; [175 0 -34.28]];
startTime = tic;
start1x = coordPos(1, 1);
start1y = coordPos(1, 2);
start1z = coordPos(1, 3);

totalTime = [1.5 3 2.5 2 2.5 3 3 1.5];
totalSteps = [30 30 30 30 30 30 30 30];
graphTime = tic;
for k = 1:8
    timer = tic;
    pos = zeros(totalSteps(k), 3);
    constantValuesX = quinticPoly(start1x, coordPos(k+1, 1), 0, totalTime(k), 0, 0, 0, 0);
    constantValuesY = quinticPoly(start1y, coordPos(k+1, 2), 0, totalTime(k), 0, 0, 0, 0);
    constantValuesZ = quinticPoly(start1z, coordPos(k+1, 3), 0, totalTime(k), 0, 0, 0, 0);
    for j = 1:totalSteps(k)
        time = toc(timer);
        xPos = quinticTrajectory(constantValuesX, time);
        yPos = quinticTrajectory(constantValuesY, time);
        zPos = quinticTrajectory(constantValuesZ, time);
        pos(j,:) = ikin([xPos yPos zPos])
        pause(totalTime(k)/totalSteps(k));
    end
    for i = 1:totalSteps(k)
        pid_packet(1) = pos(i,1);
        pid_packet(4) = pos(i,2);
        pid_packet(7) = pos(i,3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        time = toc(startTime);
        
        addpoints(path, double (points(1,4)), double (points(2,4)), double (points(3,4)));
        dlmwrite('jointxyzData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1, 4) points(3, 4) points(2, 4) time], 'delimiter',',','-append');
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        drawnow();
    end
    start1x = coordPos(k+1, 1);
    start1y = coordPos(k+1, 2);
    start1z = coordPos(k+1, 3);
end
%csvPlot('csv/jointxyzData.csv');