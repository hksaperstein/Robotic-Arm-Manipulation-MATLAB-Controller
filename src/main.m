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
%     while(1)
%         time = toc(tic);
%         return_status_packet = statusCom(pp, STATUS_ID, status_packet);
% %         jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
% %         torqueJ1 = return_status_packet(3);
% %         torqueJ2 = return_status_packet(6);
% %         torqueJ3 = return_status_packet(9);
% %         torques = [torqueJ1 torqueJ2 torqueJ3];
% %         tipForces = inverseForce(torques, jacobian(1:3,1:3))*10000
%         points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)])
%         set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
% %         set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
%         drawnow()
%         pause(.1);
%     end 
    state = 'moveToBase';
    previousState = 'moveToDropOff';
    currentPosition = homePosition;
    nextPosition = basePosition;
    tipVelocity = 25;
    image = snapshot(cam);
    totalTime = norm((nextPosition - currentPosition) / tipVelocity);
    [newCoordinates, color] = imageProcess(image);
    gripperCom(pp, GRIPPER_ID, gripper_packet, 1);
    while(~strcmp('none',color))
        switch state

            case 'image'
                image = snapshot(cam);
                oldCoordinates = newCoordinates;
                [newCoordinates, color] = imageProcess(image);
                switch previousState
                    case 'moveToBase'
                        nextPosition = [(newCoordinates(x) + 175) newCoordinates(y) currentPosition(3)];
                        state = 'moveOverBall';
                    case 'moveOverBall'
                        if(abs(oldCoordinates - newCoordinates) > 2)
                            nextPosition = [(newCoordinates(x) + 175) newCoordinates(y) currentPosition(3)];
                            state = 'moveOverBall';
                        else
                            nextPosition = [(oldCoordinates(x) + 175) oldCoordinates(y) ballZ];
                            state = 'moveToBall';
                        end
                end
                
                previousState = 'image';
            
            case 'moveToBase'
                
                
                quinticTrajectoryScript
                
                switch previousState
                    %% ball gets weighed and moves to corresponding drop off positions
                    case 'moveToBall'
                        weight = 'heavy';
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
                
                quinticTrajectoryScript;
                
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                
                state = 'image';
                previousState = 'moveOverBall';
        
            case 'moveToBall'
                
                
                nextPosition = [currentPosition(x) currentPosition(y) ballZ];
                
                quinticTrajectoryScript;
                gripperCom(pp, GRIPPER_ID, gripper_packet, 0);
                
                returnStatusPacket = statusCom(pp,STATUS_ID,status_packet);
                returnStatusPacket = pose([returnStatusPacket(1) returnStatusPacket(4) returnStatusPacket(7)]);
                currentPosition = [returnStatusPacket(1,4) returnStatusPacket(2,4) returnStatusPacket(3,4)];
                nextPosition = basePosition;
                
                state = 'moveToBase';
                previousState = 'moveToBall';
            case 'moveToDropOff'
                
                
                quinticTrajectoryScript
                gripperCom(pp, GRIPPER_ID,gripper_packet, 1);
                
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
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
%toc;
clear