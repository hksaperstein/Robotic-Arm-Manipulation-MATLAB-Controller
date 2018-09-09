function [plotCSV] = csvPlot( fileName )
    
    fileName = csvread(fileName);
    [m,n] = size(fileName);
    joint1Ang = fileName(:,1)'
    joint2Ang = fileName(:,2)';
    joint3Ang = fileName(:,3)';
    xPos = fileName(:,4)';
    zPos = fileName(:,5)';
    time = fileName(:,6)'
    joint1Vel = diff(joint1Ang);
    joint2Vel = diff(joint2Ang);
    joint3Vel = diff(joint3Ang);
    figure(2)
    hold on;
    subplot(3, 1, 1)
    plot(time, joint1Ang, time, joint2Ang, time, joint3Ang);
    title("Joint Angles vs. Time");
    
    subplot(3,1,2)
    plot(time, xPos, time, zPos);
    title("X-Z End Effector Position vs. Time");
    
    subplot(3,1,3)
    plot(time(1, 1:end-1), joint1Vel(), time(1, 1:end-1), joint2Vel, time(1, 1:end-1), joint3Vel);
    title("X-Z End Effector Position vs. Time");
    
end

