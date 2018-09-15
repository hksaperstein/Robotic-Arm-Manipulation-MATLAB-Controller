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


pos1 = ikin([175,0,-34.28]);
pos2 = ikin([0,-344.28,135]);
position = [pos2(1,:); pos1(1,:)];
startTime = tic;
time = 0;
for i = 1:2
    while(time < i)
        pos = position(i,:);
        pid_packet(1) = pos(1);
        pid_packet(4) = pos(2);
        pid_packet(7) = pos(3);
        return_pid_packet = pidCom(pp, PID_ID, pid_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
        time = toc(startTime);
        dlmwrite('csv/jointxyzData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1, 4) points(3, 4) points(2, 4) time], 'delimiter',',','-append');
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        drawnow();
    end
end
csvPlot('csv/jointxyzData.csv');