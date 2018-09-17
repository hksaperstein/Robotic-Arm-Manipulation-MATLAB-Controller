%%
% RBE3001 - Laboratory 1 
% 
% Instructions
% ------------
% Welcome again! This MATLAB script is your starting point for Lab
% 1 of RBE3001. The sample code below demonstrates how to establish
% communication between this script and the Nucleo firmware, send
% setpoint commands and receive sensor data.
% 
% IMPORTANT - understanding the code below requires being familiar
% with the Nucleo firmware. Read that code first.
initScript;
% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(myHIDSimplePacketComs);
constants;
fopen('jointData.csv', 'w');
fopen('jointxyzData.csv', 'w');
try
    %% initiation of server packets, calibration of arm, PID configuration
    packets;
    calibration;
    pidConfiguration;
% 
     tic;
%     return_pid_packet = pp.command(PID_ID, pid_packet);
%     y1 = double (return_pid_packet(1));
%     y2 = double (return_pid_packet(4));
%     y3 = double (return_pid_packet(7));
%  
%     x = 0;
%     trianglePtsx = [0, 200, 0, -200, 200, 0,0];
%     trianglePtsy = [0, 0, 0, 0, 0, 0,0];
%     trianglePtsz = [0, 400, 1000, 400, 400,0,0];
%     start1x = trianglePtsx(1);
%     start1y= trianglePtsy(1);
%     start1z = trianglePtsz(1);
%     totalTime = 30;
%   
  %Time for graph tics
%   graphTime = tic;
 %%
%   for k = (1:6)
%         timer = tic;
%      
%         constantValuesJoint1 = cubicPoly(start1y, trianglePtsy(k+1), 0, totalTime, 0, 0);
%         constantValuesJoint2 = cubicPoly(start1z, trianglePtsz(k+1), 0, totalTime, 0, 0);
%         constantValuesJoint3 = cubicPoly(start1x, trianglePtsx(k+1), 0, totalTime, 0, 0);
%           for j = 1:20
%             time = toc(timer);
%             joint1Q = cubicTrajectory(constantValuesJoint1, time);
%             joint2Q = cubicTrajectory(constantValuesJoint2, time);
%             joint3Q = cubicTrajectory(constantValuesJoint3, time);
%             pid_packet(1) = joint1Q;
%             pid_packet(4) = joint2Q;
%             pid_packet(7) = joint3Q;
%             return_pid_packet = pp.command(PID_ID, pid_packet);
%             
%             y1 = [y1 (double (return_pid_packet(1)))];
%             y2 = [y2 (double (return_pid_packet(4)))];
%             y3 = [y3 (double (return_pid_packet(7)))];
%             x = [x toc(graphTime)];
%         
%             set(positionPlot(1), 'xdata', x, 'ydata', y1);
%             set(positionPlot(2), 'xdata', x, 'ydata', y2);
%             set(positionPlot(3), 'xdata', x, 'ydata', y3);
% 
%             points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
%             dlmwrite('jointData.csv', [return_pid_packet(1) return_pid_packet(4) return_pid_packet(7) points(1,4) points(3,4) toc(graphTime)], 'delimiter',',','-append');
%             set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
%             addpoints(path,double (points(1,4)), double (points(2,4)), double (points(3,4)));
%             drawnow();
%             pause(.5);
%             
%           end
%         start1x = trianglePtsx(k+1);
%         start1y= trianglePtsy(k+1);
%         start1z = trianglePtsz(k+1);
% 
%   end 
%   initialSample = tic;
%  csvPlot('jointData.csv');
%% Timestamp Calc Part 1
    %timeStamp


%% Inverse Kinematics Setpoints
    %inverseKin
%% Quintic Trajectory
    shapeTrajectoryScript
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
toc;
clear