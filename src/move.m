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
clear
clear java
%clear import;
clear classes;
vid = hex2dec('3742');
pid = hex2dec('0007');
disp (vid );
disp (pid);
javaaddpath ../lib/SimplePacketComsJavaFat-0.6.4.jar;
import edu.wpi.SimplePacketComs.*;
import edu.wpi.SimplePacketComs.device.*;
import edu.wpi.SimplePacketComs.phy.*;
import java.util.*;
import org.hid4java.*;
version -java;
myHIDSimplePacketComs=HIDfactory.get();
myHIDSimplePacketComs.setPid(pid);
myHIDSimplePacketComs.setVid(vid);
myHIDSimplePacketComs.connect();
% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(myHIDSimplePacketComs); 
try
    PID_ID = 37;            % we will be talking to server ID 37 on the Nucleo
    STATUS_ID = 01;
    CALIBRATE_ID = 50;
    PID_CONFIG_ID = 65;
    DEBUG   = false;          % enables/disables debug prints

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall that the HID interface supports
  % packet sizes up to 64 bytes.
    pid_packet = zeros(15, 1, 'single');
    pid_config_packet = zeros(15, 1, 'single');
    status_packet = zeros(15, 1, 'single');
    
    % sends initial packet of zeros through calibration server
    calibrate_packet = zeros(15, 1, 'single');
    pp.write(CALIBRATE_ID, calibrate_packet);
    
    return_calibrate_matrix = zeros(6,15);
    
    tic;
    for i = (1:6)
        %pp.write(STATUS_ID, status_packet);
        pause(.003)
        return_status_packet = pp.command(STATUS_ID, status_packet);
        
        return_calibrate_matrix(i,:) = return_status_packet;
        if DEBUG
          %disp('Sent Packet:');
          disp(status_packet);
          %disp('Received Packet:');
          disp(return_status_packet);
        end
        toc;
        pause(.2);
    end
    return_calibrate_matrix;
    calibration_matrix = calibrate(return_calibrate_matrix)
    
    for i = 1:3
        calibrate_packet((i*3)-2) = calibration_matrix(1,i);
    end
    pp.write(CALIBRATE_ID, calibrate_packet);
    
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  viaPts2 = [800, 400, 800, 400, 0]
  viaPts1 = [0, -400, 400, -400, 0]
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
  tic
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
      addpoints(j1,x,y1)
      addpoints(j2,x,y2)
      addpoints(j3,x,y3)
      grid on;
      drawnow
      
      
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