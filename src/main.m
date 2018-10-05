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
<<<<<<< HEAD
    tic;
=======
      tic;
>>>>>>> 613970b3e9f3fca1d2ca17527d6f4f82a1efc5d0
    figure1 = figure;
    hold on;
    grid on;
    view(3);
    axis([-0 400 -400 400 -50 450]);
    xlabel({'X Position (mm)'});
    zlabel({'Z Position (mm)'});
    ylabel({'Y Position (mm)'});
    title({'3D Stick Plot of Arm'});
<<<<<<< HEAD
    
    points = pose([0 0 0]);
    R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
    Q.handle = quiver3(points(1,4), points(2,4), points(3,4),0, 0, 0, 'MaxHeadSize', 200);
    while(1)
        time = toc(tic);
        return_status_packet = statusCom(pp, STATUS_ID, status_packet);
        jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        torqueJ1 = return_status_packet(3);
        torqueJ2 = return_status_packet(6);
        torqueJ3 = return_status_packet(9);
        torques = [torqueJ1 torqueJ2 torqueJ3] * 100;
        tipForces = inverseForce(torques, jacobian(1:3,1:3))*100;
        points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
        drawnow()
    end
    
=======
>>>>>>> 613970b3e9f3fca1d2ca17527d6f4f82a1efc5d0
    
    points = pose([0 0 0]);
    R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
    Q.handle = quiver3(points(1,4), points(2,4), points(3,4),0, 0, 0, 'MaxHeadSize', 200);
    while(1)
        time = toc(tic);
        return_status_packet = statusCom(pp, STATUS_ID, status_packet);
        jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        torqueJ1 = return_status_packet(3);
        torqueJ2 = return_status_packet(6);
        torqueJ3 = return_status_packet(9);
        torques = [torqueJ1 torqueJ2 torqueJ3];
        tipForces = inverseForce(torques, jacobian(1:3,1:3))*10000
        points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
        drawnow()
        pause(.1);
    end 
    
%% Forward Velocity Kinematics
    %forwardVelocityScript
%% Inverse Velocity Kinematics
   % inverseVelocityScript
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