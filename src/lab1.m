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
pp2 = PacketProcessor(myHIDSimplePacketComs); 
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

  
    fopen('Lab1test.csv', 'w');
    fopen('Lab1Return.csv', 'w');
    fopen('jointPlot.csv', 'w');  % header

  % Iterate through a sine wave for joint values
  i = 0;
  tic
  for k = viaPts
  
      %incremtal = (single(k) / sinWaveInc);
      packet = zeros(15, 1, 'single');
      packet(1) = k;

     
      % Send packet to the server and get the response
      returnPacket = pp.command(SERV_ID, packet);

      toc

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
      %THis version will send the command once per call of pp.write
      pp.write(65, packet);
      pause(0.003);
      returnPacket2=  pp.read(65);
      %this version will start an auto-polling server and read back the
      %current data
      %returnPacket2=  pp.command(65, packet);
      if DEBUG
          disp('Received Packet 2:');
          disp(returnPacket2);
      end
      toc
      pause(1) %timeit(returnPacket) !FIXME why is this needed?
      i= i +1;
  end

  pause(.02)
  jointHome = calibrate('Lab1test.csv');
  for i = (1:3)
      cali_packet((i*3) -2) = jointHome(i);
  end
  for i = (0:10)
    returnCalibrate = pp.command(CALI_ID, cali_packet);
    dlmwrite('Lab1Return.csv', returnCalibrate','delimiter',' ','-append');
        if DEBUG
             disp('Sent Packet:');
             disp(cali_packet);
             disp('Received Packet:');
            disp(returnCalibrate);
        end
  end
  
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()

toc
clear