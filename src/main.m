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
try
    pose([0 0 0]);

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall that the HID interface supports
  % packet sizes up to 64 bytes.
    packets;
    
  % Calibration of initial position of arm
   calibration;
    
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  %viaPts1 = [0, -400, 400, -400, 0];
  %viaPts2 = [400, 200, 400, 200, 0];
 
 
  %viaPts1 = [0, 1200, 0]
    p = .005;
    i = .00;
    d = .035;
  pid_config_packet(1) = .0025; %joint1P
  %pid_config_packet(2) = 0; %joint1I
  pid_config_packet(3) = .025;  %joint1D
  pid_config_packet(4) = .0015;  %joint2P
  pid_config_packet(5) = .001;  %joint2I
   pid_config_packet(6) = .065; %joint2D
  pid_config_packet(7) = .005; %joint3P
  %pid_config_packet(8) = i; %joint3I
  pid_config_packet(9) = .035; %joint3D
  
  pp.write(PID_CONFIG_ID, pid_config_packet);
  pause(.003);
  return_pid_config_packet = pp.read(PID_CONFIG_ID);
  disp(pid_config_packet);
  disp(return_pid_config_packet);
  
  % Iterate through a sine wave for joint values/Live Plotting
%   figure3 = figure;
%   hold on;
%   grid on;
%    positionPlot = plot(0, 0, 0, 0, 0, 0);

%     figure1 = figure;
%     hold on;
%     grid on;
%     points = pose([0 0 0]);
%     R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
%     'Marker','o',...
%     'Color',[0 1 0]);
%     
%     hold on;
%     grid on;
%     view(3);
%     axis([-150 350 -250 250 -100 400]);
    
  tic;
  return_pid_packet = pp.command(PID_ID, pid_packet);
  y1 = double (return_pid_packet(1));
  y2 = double (return_pid_packet(4));
  y3 = double (return_pid_packet(7));
  
  %Animated Live Plot
%   points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
%   points = double (points);
%   path = animatedline(points(1,4),points(2,4), points(3,4));

  x = 0;
  trianglePtsx = [0, 200, 0, -200, 200, 0,0];
  trianglePtsy = [0, 0, 0, 0, 0, 0,0];
  trianglePtsz = [0, 400, 1000, 400, 400,0,0];
  start1x = trianglePtsx(1);
  start1y= trianglePtsy(1);
  start1z = trianglePtsz(1);
  totalTime = 30;
  
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
%   end initialSample = tic;
%  csvPlot('jointData.csv');
%% Timestamp Calc Part 1


% fopen('TimestampData.csv','w');
%   for i = (1:500)
%        initialSample = tic;
%        return_status_packet = pp.command(STATUS_ID, status_packet);
%        stamp =  toc(initialSample);
%        dlmwrite('TimestampData.csv', stamp, 'delimiter', ',', '-append');
%   end
%   array= csvread('TimestampData.csv');
%   histogram(array);
%   arraySTD = std(array)
%   arrayAvg = mean(array)
%   arrayMax = max(array)
%   arrayMin = min(array)

%% Inverse Kinematics Setpoints
pos1 = ikin([175,0,-34.28]);
pos2 = ikin([0,0,479.28])

  pid_packet(1) = pos2(1);
  pid_packet(4) = pos2(2);
  pp.write(PID_ID, pid_packet);
  pause(5);
  pid_packet(7) = pos2(3);
  pp.write(PID_ID, pid_packet);

catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
toc;
clear