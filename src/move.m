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
    DEBUG   = false;          % enables/disables debug prints

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall that the HID interface supports
  % packet sizes up to 64 bytes.
    pid_packet = zeros(15, 1, 'single');
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
  viaPts = [0, 1200, 0]

  

  % Iterate through a sine wave for joint values
  for k = viaPts
      tic;
      %incremtal = (single(k) / sinWaveInc);
      pid_packet(1) = k;
      pid_packet(4) = k;
      pid_packet(7) = k;

     
      % Send packet to the server and get the response
      return_pid_packet = pp.command(PID_ID, pid_packet);
      
      
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