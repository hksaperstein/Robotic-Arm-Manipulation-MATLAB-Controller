function [plotCSV] = csvPlot( fileName )
    
    fileName = csvread(fileName);
    [m,n] = size(fileName);
    joint1Ang = fileName(:,1)'
    joint2Ang = fileName(:,2)';
    joint3Ang = fileName(:,3)';
    xPos = fileName(:,4)';
    yPos = fileName(:,5)';
    zPos = fileName(:,6)';
    time = fileName(:,7)';
    
    joint1Vel = diff(xPos)./time(1, 2:end);
    joint2Vel = diff(yPos)./time(1, 2:end);
    joint3Vel = diff(zPos)./time(1, 2:end);
    joint1Vel =  joint1Vel'
    joint2Vel =  joint2Vel'
    joint3Vel =  joint3Vel'
    
    joint1Acc = diff(joint1Vel')./time(1, 3:end);
    joint2Acc = diff(joint2Vel')./time(1, 3:end);
    joint3Acc = diff(joint3Vel')./time(1, 3:end);
    
    joint1Acc =  joint1Acc'
    joint2Acc =  joint2Acc'
    joint3Acc =  joint3Acc'
    figure(2)
    hold on;
    plot(time, joint1Ang, time, joint2Ang, time, joint3Ang);
    title("Joint Angles vs. Time");
    xlabel("Time (Seconds)");
    ylabel("Angle (Degrees)");
    hold off
    
    figure(3)
    hold on;
    plot(time, xPos, time, yPos, time, zPos);
    title("X, Y, Z End Effector Positions vs. Time");
    xlabel("Time (Seconds)");
    ylabel("Position (mm)");
    hold off;
    
    figure(4)
    hold on;
    plot(time(2:end), joint1Vel, time(1, 2:end), joint2Vel, time(1, 2:end), joint3Vel);
    title("End Effector X-Y-Z Velocity vs. Time");
    xlabel("Time (Seconds)");
    ylabel("Velocity (mm/s)");
    hold off;
    
    figure(5)
    hold on;
    plot(time(1, 3:end), joint1Acc, time(1, 3:end), joint2Acc, time(1, 3:end), joint3Acc);
    title("End Effector X-Y-Z Acceleration vs. Time");
    xlabel("Time (Seconds)");
    ylabel("Acceleration (mm/s^2)");
    hold off;
%     subplot(3,1,3)
%     plot(time(1, 1:end-1), joint1Vel(), time(1, 1:end-1), joint2Vel, time(1, 1:end-1), joint3Vel);
%     title("X-Z End Effector Position vs. Time");
    
end

