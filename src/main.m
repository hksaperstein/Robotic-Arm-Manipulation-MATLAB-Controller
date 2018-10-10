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
% %     
%   while(1)
%       position = input('input value: ');
%       gripperCom(pp, GRIPPER_ID, gripper_packet, position);
%         pause(2);
%   end

%     figure1 = figure;
%     hold on;
%     grid on;
%     view(3);
%     axis([-0 400 -400 400 -50 450]);
%     xlabel({'X Position (mm)'});
%     zlabel({'Z Position (mm)'});
%     ylabel({'Y Position (mm)'});
%     title({'3D Stick Plot of Arm'});
%     
%     tic;
%     points = pose([0 0 0]);
%     R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1], 'Marker','o', 'Color',[0 1 0]);
%     Q.handle = quiver3(points(1,4), points(2,4), points(3,4),0, 0, 0, 'MaxHeadSize', 200);
%     pause(1);
%     return_status_packet = statusCom(pp, STATUS_ID, status_packet);
%     jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
%     torqueJ10 = return_status_packet(3);
%     torqueJ20 = return_status_packet(6);
%     torqueJ30 = return_status_packet(9);
%     torques0 = [torqueJ10 torqueJ20 torqueJ30];
%     tipForces0 = inverseForce(torques0, jacobian(1:3,1:3))*1000;
%     while(1)
%         time = toc(tic);
%         return_status_packet = statusCom(pp, STATUS_ID, status_packet);
%         jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
%         torqueJ1 = return_status_packet(3);
%         torqueJ2 = return_status_packet(6);
%         torqueJ3 = return_status_packet(9);
%         torques = [torqueJ1 torqueJ2 torqueJ3] - torques0;
%         tipForces = inverseForce(torques, jacobian(1:3,1:3))*1000;
%         points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)])
%         set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
%         set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
%         drawnow()
%         pause(.1);
%     end 



    state = 'image';
    previousState = 'moveToBase';
    currentPosition = homePosition;
    nextPosition = basePosition;
    tipVelocity = 25;
    totalTime = norm((nextPosition - currentPosition) / tipVelocity);
    quinticTrajectoryScript
%     gripperCom(pp, GRIPPER_ID, gripper_packet, );
%     pause(1);
%     gripperCom(pp, GRIPPER_ID, gripper_packet, 1);

    
    returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
    returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
    currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
    torqueOffset = 0;
    for i = 1:10
%         time = toc(tic);
        return_status_packet = statusCom(pp, STATUS_ID, status_packet);
        jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        torqueJ1 = return_status_packet(3);
        torqueJ2 = return_status_packet(6);
        torqueJ3 = return_status_packet(9);
        torqueOffset = torqueOffset + torqueJ3;
%         torques = [torqueJ1 torqueJ2 torqueJ3] - torques0;
%         tipForces = tipForces + inverseForce(torques, jacobian(1:3,1:3))*1000;
%         points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)])
%         set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
%         set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
%         drawnow()
        pause(.1);
    end 
    torqueOffset = torqueOffset / 10;
     
    image = snapshot(cam);
    
    imshow(image)
    [newCoordinates, color] = imageProcess(image);
    
    while(~strcmp('none',color))
        switch state

            case 'image'
                image = snapshot(cam);
                oldCoordinates = newCoordinates;
                [newCoordinates, color] = imageProcess(image);
                newCoordinates = newCoordinates * 10;
                if(~strcmp('none',color))
                    switch previousState
                        case 'moveToBase'
                            nextPosition = [(newCoordinates(x) + 175) newCoordinates(y) currentPosition(3)]
                            state = 'moveOverBall';
                        case 'moveOverBall'
                            if(abs(oldCoordinates - newCoordinates) > 2)
                                nextPosition = [(newCoordinates(x) + 175) newCoordinates(y) currentPosition(3)]
                                state = 'moveOverBall';
                            else
                                nextPosition = [(oldCoordinates(x) + 175) oldCoordinates(y) ballZ];
                                state = 'moveToBall';
                            end
                    end
                end
                
                previousState = 'image';
            
            case 'moveToBase'
                
                totalTime = norm((nextPosition - currentPosition) / tipVelocity);
                quinticTrajectoryScript
                
                switch previousState
                    %% ball gets weighed and moves to corresponding drop off positions
                    case 'moveToBall'
                        weighMe
                        switch weight
                            case 'heavy'
                                switch color
                                    case 'blue'
                                        nextPosition = heavyBlue;
                                    case 'green'
                                        nextPosition = heavyGreen;
                                    case 'yellow'
                                        nextPosition = heavyYellow;
                                end
                                
                            case 'light'
                                switch color
                                    case 'blue'
                                        nextPosition = lightBlue;
                                    case 'green'
                                        nextPosition = lightGreen;
                                    case 'yellow'
                                        nextPosition = lightYellow;
                                end
                        end
                        state = 'moveToDropOff';
                   
                    case 'moveToDropOff'
                       state = 'image';
                end
                
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                
                previousState = 'moveToBase';
                
                
                
            case 'moveOverBall'
                totalTime = norm((nextPosition - currentPosition) / tipVelocity);
                quinticTrajectoryScript;
                
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                
                state = 'image';
                previousState = 'moveOverBall';
        
            case 'moveToBall'
                
                
                nextPosition = [currentPosition(x) currentPosition(y) ballZ];
                totalTime = norm((nextPosition - currentPosition) / tipVelocity);
                quinticTrajectoryScript;
                pause(1);
                gripperCom(pp, GRIPPER_ID, gripper_packet, 0);
                pause(1);
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                nextPosition = basePosition;
                
                state = 'moveToBase';
                previousState = 'moveToBall';
            case 'moveToDropOff'
                
                totalTime = norm((nextPosition - currentPosition) / tipVelocity);
                quinticTrajectoryScript
                pause(1);
                gripperCom(pp, GRIPPER_ID,gripper_packet, .5);
                pause(1);
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                nextPosition = basePosition;
                
                state = 'moveToBase';
                previousState = 'moveToDropOff';
        end
        state
        previousState
    end
    disp("No object Detected");
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
%toc;
clear