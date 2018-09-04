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
javaaddpath ../lib/SimplePacketComsJavaFat-0.6.2.jar;
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
    DEBUG   = true;          % enables/disables debug prints

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall that the HID interface supports
  % packet sizes up to 64 bytes.
    pid_packet = zeros(15, 1, 'single');
    status_packet = zeros(15, 1, 'single');
    
    % sends initial packet of zeros through calibration server
    calibrate_packet = zeros(15, 1, 'single');
    pp.command(CALIBRATE_ID, calibrate_packet);
    return_status_packet_matrix = pp.command(STATUS_ID, status_packet);
    for i = (0:6)
        return_status_packet = pp.command(STATUS_ID, status_packet);
        % FIXME MAke faster /initially allocate space
        return_status_packet_matrix = [return_status_packet_matrix;
                                         return_status_packet] 
    end
    calibrate(return_status_packet_matrix);
    
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  viaPts = [0, -400, 400, -400, 400, 0];

  

  % Iterate through a sine wave for joint values
  for k = viaPts
      tic
      %incremtal = (single(k) / sinWaveInc);
      packet = zeros(15, 1, 'single');
      packet(1) = k;

     
      % Send packet to the server and get the response
      returnPacket = pp.command(PID_ID, packet);
      
      
      if DEBUG
          disp('Sent Packet:');
          disp(packet);
          disp('Received Packet:');
          disp(returnPacket);
      end
      
      for x = 0:3
          packet((x*3)+1)=0.1;
          packet((x*3)+2)=0;
          packet((x*3)+3)=0;
      end
      pp.write(65, packet);
      returnPacket2=  pp.read(65);
      if DEBUG
          disp('Received Packet 2:');
          disp(returnPacket2);
      end
      toc
      pause(1) %timeit(returnPacket) !FIXME why is this needed?
      
  end
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
toc
clear