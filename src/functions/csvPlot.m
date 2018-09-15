function [plotCSV] = csvPlot( fileName )
    
    fileName = csvread(fileName);
    [m,n] = size(fileName);
    joint1Ang = fileName(:,1)'
    joint2Ang = fileName(:,2)';
    joint3Ang = fileName(:,3)';
    xPos = fileName(:,4)';
    yPos = fileName(:,5)';
    zPos = fileName(:,6)';
    time = fileName(:,7)'
    joint1Vel = diff(joint1Ang);
    joint2Vel = diff(joint2Ang);
    joint3Vel = diff(joint3Ang);
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
%     subplot(3,1,3)
%     plot(time(1, 1:end-1), joint1Vel(), time(1, 1:end-1), joint2Vel, time(1, 1:end-1), joint3Vel);
%     title("X-Z End Effector Position vs. Time");
    
end

