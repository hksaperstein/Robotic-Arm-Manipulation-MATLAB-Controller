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

try
    pose([0 0 0]);

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall that the HID interface supports
  % packet sizes up to 64 bytes.
    packets;
    
  % Calibration of initial position of arm
    %calibration;
    
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  viaPts2 = [400, 200, 400, 200, 0];
  viaPts1 = [0, -400, 400, -400, 0];
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
  % Iterate through a sine wave for joint values
%   figure3 = figure;
%   hold on;
%   grid on;
%   positionPlot = plot(0, 0, 0, 0, 0, 0);

    figure1 = figure;
    hold on;
    grid on;
    points = pose([0 0 0]);
    R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
    'Marker','o',...
    'Color',[0 1 0]);
    
    hold on;
    grid on;
    view(3);
    axis([-150 350 -250 250 -100 400]);
    
  tic;
  return_pid_packet = pp.command(PID_ID, pid_packet);
  y1 = double (return_pid_packet(1));
  y2 = double (return_pid_packet(4));
  y3 = double (return_pid_packet(7));
  points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
  points = double (points)
  path = animatedline(points(1,4),points(2,4), points(3,4));
  x = 0;
  for k = (1:5)
      
      %while((y1(end) >= viaPts1(k)*1.05 || y1(end) <= viaPts1(k) *.95) && (y2(end) >= viaPts2(k) * 1.05 || y2(end) <= viaPts2(k) *.95) && (y3(end) >= viaPts2(k) * 1.05 || y3(end) <= viaPts2(k) *.95))
      %while(toc < k*1.5)
      while(1)
          %incremtal = (single(k) / sinWaveInc);
          pid_packet(1) = viaPts1(k);
          pid_packet(4) = viaPts2(k);
          pid_packet(7) = viaPts2(k);
% % 
% %      
% %       % Send packet to the server and get the response
        return_pid_packet = pp.command(PID_ID, pid_packet);
% %       %y1 = [y1 (double (return_pid_packet(1)))];
% %       y2 = [y2 (double (return_pid_packet(4)))];
% %       %y3 = [y3 (double (return_pid_packet(7)))];
% %       x = [x toc];
% %       %set(positionPlot(1), 'xdata', x, 'ydata', y1);
% %       set(positionPlot(2), 'xdata', x, 'ydata', y2);
% %       %set(positionPlot(3), 'xdata', x, 'ydata', y3);

        %status_return_packet = pp.command(STATUS_ID, status_packet);

        points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)])
        
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        addpoints(path,double (points(1,4)), double (points(2,4)), double (points(3,4)));
        drawnow();
  
      end
      
      
%       if DEBUG
%         4  disp('Sent Packet:');
%           disp(pid_packet);
%           disp('Received Packet:');
%           disp(return_pid_packet);
%       end
      
     % pp.write(PID_ID, pid_packet);
      %return_pid_packet=  pp.read(PID_ID);
      if DEBUG
          %disp('Received Packet 2:');
          %disp(return_pid_packet);
      end
      toc;
      pause(1); %timeit(returnPacket) !FIXME why is this needed?
      
  end
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
toc;
clear