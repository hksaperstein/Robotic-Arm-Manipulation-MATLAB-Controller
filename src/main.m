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
    calibration;
    
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  viaPts2 = [800, 400, 800, 400, 0];
  viaPts1 = [0, -400, 400, -400, 0];
  %viaPts1 = [0, 1200, 0]
    p = .005;
    i = .00;
    d = .035;
  pid_config_packet(1) = .0025; %joint1P
  %pid_config_packet(2) = 0; %joint1I
  pid_config_packet(3) = .025;  %joint1D
  pid_config_packet(4) = .005;  %joint2P
  %pid_config_packet(5) = i;  %joint2I
   pid_config_packet(6) = .035; %joint2D
  pid_config_packet(7) = .005; %joint3P
  %pid_config_packet(8) = i; %joint3I
  pid_config_packet(9) = .035; %joint3D
  
  pp.write(PID_CONFIG_ID, pid_config_packet);
  pause(.003);
  return_pid_config_packet = pp.read(PID_CONFIG_ID);
  disp(pid_config_packet);
  disp(return_pid_config_packet);
  % Iterate through a sine wave for joint values
  
  hold on;
  createfigure();
  
  j1 = animatedline('color', 'g');
  j2 = animatedline('color', 'r');
  j3 = animatedline('color', 'b');
  tic;
  for k = (1:5)
      
      
      
      %incremtal = (single(k) / sinWaveInc);
      pid_packet(1) = viaPts1(k);
      pid_packet(4) = viaPts2(k);
      pid_packet(7) = viaPts2(k);

     
      % Send packet to the server and get the response
      return_pid_packet = pp.command(PID_ID, pid_packet);
      y1 = double (return_pid_packet(1));
      y2 = double (return_pid_packet(4));
      y3 = double (return_pid_packet(7));
      x = toc;
      addpoints(j1,x,y1);
      addpoints(j2,x,y2);
      addpoints(j3,x,y3);
      grid on;
      drawnow;
      
      
      if DEBUG
          disp('Sent Packet:');
          disp(pid_packet);
          disp('Received Packet:');
          disp(return_pid_packet);
      end
      
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