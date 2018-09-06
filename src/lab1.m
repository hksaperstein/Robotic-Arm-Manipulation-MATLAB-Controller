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

clear java;
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
version -java
myHIDSimplePacketComs=HIDfactory.get();
myHIDSimplePacketComs.setPid(pid);
myHIDSimplePacketComs.setVid(vid);
myHIDSimplePacketComs.connect();
% Create a PacketProcessor object to send data to the nucleo firmware
pp = PacketProcessor(myHIDSimplePacketComs); 
try
  SERV_ID = 01;            % we will be talking to server ID 37 on
  CALI_ID = 50;                       % the Nucleo

  DEBUG   = true;          % enables/disables debug prints

  % Instantiate a packet - the following instruction allocates 64
  % bytes for this purpose. Recall thite('Lab1test.csv', returnPacket','delimiter',' ','-append')at the HID interface supports
  % packet sizes up to 64 bytes.
  packet = zeros(15, 1, 'single');
  cali_packet = zeros(15, 1, 'single');
  pp.command(CALI_ID, cali_packet);
  % The following code generates a sinusoidal trajectory to be
  % executed on joint 1 of the arm and iteratively sends the list of
  % setpoints to the Nucleo firmware. 
  viaPts = [0, -400, 400, -400, 400, 0];
  
  figure(1)
  hold on;
  
  j1 = animatedline('color', 'g');
  j2 = animatedline('color', 'r');
  j3 = animatedline('color', 'b');
  tic
  for i = 1:100
      returnP = pp.command(SERV_ID, packet);
      y1 = double (returnP(1));
      y2 = double (returnP(4));
      y3 = double (returnP(7));
      x = toc;
      addpoints(j1,x,y1)
      addpoints(j2,x,y2)
      addpoints(j3,x,y3)
      grid on;
      drawnow
      pause(.1)
  end
  
 
  
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()

toc
clear