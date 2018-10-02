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
fopen('csv/angularVel.csv', 'w');
try
    %% initiation of server packets, calibration of arm, PID configuration
    packets; 
    calibration;
    pidConfiguration;
     while(1)
         return_status_packet = statusCom(pp, STATUS_ID, status_packet);
         jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
         torqueJ1 = return_status_packet(3);
         torqueJ2 = return_status_packet(6);
         torqueJ3 = return_status_packet(9);
         torques = [torqueJ1 torqueJ2 torqueJ3];
         inverseForce(torques, jacobian(1:3,1:3))
         
     end
    
    
    
%% Forward Velocity Kinematics
    %forwardVelocityScript
%% Inverse Velocity Kinematics
    inverseVelocityScript
%% Timestamp Calc Part 1
    %timeStamp
%% Inverse Kinematics Setpoints
    %inverseKin
%% Quintic Trajectory
    %quinticTrajectoryScript
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
%toc;
clear