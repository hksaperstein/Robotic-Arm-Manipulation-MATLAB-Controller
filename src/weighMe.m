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
    tipForces = [0 0 0];
    torqueJ1 = 0;
    torqueJ2 = 0;
    torqueJ3 = 0;
    
    
    return_status_packet = statusCom(pp, STATUS_ID, status_packet);
    jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
    torqueJ10 = return_status_packet(3);
    torqueJ20 = 0;
    torqueJ30 = return_status_packet(9);
    torques0 = [torqueJ10 torqueJ20 torqueJ30];
    tipForces0 = inverseForce(torques0, jacobian(1:3,1:3))*1000;
    pause(1);
    for i = 1:10
%         time = toc(tic);
        return_status_packet = statusCom(pp, STATUS_ID, status_packet);
        jacobian = jacob0([return_status_packet(1) return_status_packet(4) return_status_packet(7)]);
        torqueJ1 = return_status_packet(3);
        torqueJ2 = return_status_packet(6);
        torqueJ3 = return_status_packet(9);
        torqueJ30 = torqueJ30 + torqueJ3 - torqueOffset;
%         torques = [torqueJ1 torqueJ2 torqueJ3] - torques0;
%         tipForces = tipForces + inverseForce(torques, jacobian(1:3,1:3))*1000;
%         points = pose([return_status_packet(1) return_status_packet(4) return_status_packet(7)])
%         set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
%         set(Q.handle, 'xdata', points(1,4), 'ydata', points(2,4),'zdata', points(3,4),'UData', double(tipForces(1)), 'VData', double(tipForces(2)), 'WData', double(tipForces(3)), 'MaxHeadSize', 200);
%         drawnow()
        pause(.1);
    end 
    torqueJ30 = torqueJ30 / 10

    if (torqueJ30 < -2)
        weight = 'heavy'
    else 
        weight = 'light'
    end
    
    