%% Quintic Trajectory
% figure1 = figure;
% hold on;
% grid on;
% view(3);
% axis([-0 400 -400 400 -50 450]);
% xlabel({'X Position (mm)'});
% zlabel({'Z Position (mm)'});
% ylabel({'Y Position (mm)'});
% title({'3D Stick Plot of Arm'});
% points = pose([0 0 0]);
% R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
%                     'Marker','o',...
%                     'Color',[0 1 0]);
% 
% path = animatedline(points(1,4),points(2,4), points(3,4), 'MarkerFaceColor',[.110 .009 .118], 'MarkerEdgeColor', [1 1 1], 'Marker', 'o');

% setPoint Size is (totalSteps * 3)
% setPoints = quinticTrajectoryPoints(totalTime, totalSteps, currentPosition, nextPosition)

    constantValuesX = quinticPoly(currentPosition(x), nextPosition(x), 0, totalTime, 0, 0, 0, 0);
    constantValuesY = quinticPoly(currentPosition(y), nextPosition(y), 0, totalTime, 0, 0, 0, 0);
    constantValuesZ = quinticPoly(currentPosition(z), nextPosition(z), 0, totalTime, 0, 0, 0, 0);
    
    row = 0;
    time = 0;
    while(time < totalTime)
        tic;
        xPos = quinticTrajectory(constantValuesX, time);
        yPos = quinticTrajectory(constantValuesY, time);
        zPos = quinticTrajectory(constantValuesZ, time);
%         row = row + 1;
        angles = ikin([xPos yPos zPos]); 
     
        pid_packet(1) = angles(x); %setPoints(i, 1)
        pid_packet(4) = angles(y); %setPoints(i, 2)
        pid_packet(7) = angles(z); %setPoints(i, 3)
        pidCom(pp, PID_ID, pid_packet);
        pause(.1)
        time = time + toc;
        
    end

% tic;
% for i = 1:totalSteps
%     time1 = toc(tic);
%     pid_packet(1) = setPoints(i, 1)
%     pid_packet(4) = setPoints(i, 2)
%     pid_packet(7) = setPoints(i, 3)
%     returnpacket = pidCom(pp, PID_ID, pid_packet)
%     time2 = toc(tic);
%     pause((totalTimtice/totalSteps));
% end