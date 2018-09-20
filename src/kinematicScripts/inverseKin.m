%% inverse kinematics
figure1 = figure;
hold on;
grid on;
view(3);
axis([-0 400 -400 400 -50 450]);
points = pose([0 0 0]);
xlabel({'X Position (mm)'});
zlabel({'Z Position (mm)'});
ylabel({'Y Position (mm)'});
title({'3D Stick Plot of Arm'});
R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
                    'Marker','o',...
                    'Color',[0 1 0]);

pos1 = ikin([147 120 215]);
pos2 = ikin([194 -147 20]);
pos3 = ikin([135 67 -13]);


points = pose([0 0 0]);
points = double (points);
path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');
oldPos = ikin([175 0 -34.28]);
position = [oldPos(1,:); pos1(1,:); pos2(1,:); pos3(1,:); pos1(1,:)];
coordPos = [[175 0 -34.28]; [147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]];
startTime = tic;
time = 0;
for i = 2:5
    interPoints = linInterp(coordPos(i-1,:), coordPos(i,:));
    for j = 1:20
        interPoints(j,:);
        pos = ikin(interPoints(j,:));
        pid_packet(1) = pos(1);
        pid_packet(4) = pos(2);
        pid_packet(7) = pos(3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        time = toc(startTime);
        
        addpoints(path, double (points(1,4)), double (points(2,4)), double (points(3,4)));
        dlmwrite('csv/jointxyzData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1, 4) points(3, 4) points(2, 4) time], 'delimiter',',','-append');
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        drawnow();
        pause(.1);
    end
    
end
csvPlot('csv/jointxyzData.csv');