function [plotCSV] = csvPlot( fileName )
    
    fileName = csvread(fileName);
    [m,n] = size(fileName);
    joint1AngVel = fileName(:,1)'
    joint2AngVel = fileName(:,2)';
    joint3AngVel = fileName(:,3)';
    time = fileName(:,4)';

    figure(2)
    hold on;
    plot(time, joint1AngVel, time, joint2AngVel, time, joint3AngVel);
    title("Joint Anglular Velocity vs. Time");
    xlabel("Time (Seconds)");
    ylabel("Velocity (Degrees / Seconds)");
    hold off
    
%     figure(3)
%     hold on;
%     plot(time, xPos, time, yPos, time, zPos);
%     title("X, Y, Z End Effector Positions vs. Time");
%     xlabel("Time (Seconds)");
%     ylabel("Position (mm)");
%     hold off;
%     
%     figure(4)
%     hold on;
%     plot(time(2:end), joint1Vel, time(1, 2:end), joint2Vel, time(1, 2:end), joint3Vel);
%     title("End Effector X-Y-Z Velocity vs. Time");
%     xlabel("Time (Seconds)");
%     ylabel("Velocity (mm/s)");
%     hold off;
%     
%     figure(5)
%     hold on;
%     plot(time(1, 3:end), joint1Acc, time(1, 3:end), joint2Acc, time(1, 3:end), joint3Acc);
%     title("End Effector X-Y-Z Acceleration vs. Time");
%     xlabel("Time (Seconds)");
%     ylabel("Acceleration (mm/s^2)");
%     hold off;
%     subplot(3,1,3)
%     plot(time(1, 1:end-1), joint1Vel(), time(1, 1:end-1), joint2Vel, time(1, 1:end-1), joint3Vel);
%     title("X-Z End Effector Position vs. Time");
    
end

