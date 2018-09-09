%% live plot 3d arm
close all;
initScript
constants;
packets;
pp = PacketProcessor(myHIDSimplePacketComs);



try
    %calibration;
    figure1 = figure;
    hold on;
    grid on;

    calibration;
    points = pose([0 0 0]);
    R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
    'Marker','o',...
    'Color',[0 1 0]);

    hold on;
    grid on;
    view(3);
    axis([-100 400 -250 250 -100 400]);
    while(1)
        status_return_packet = pp.command(STATUS_ID, status_packet);
        
        points = pose([status_return_packet(1) status_return_packet(4) status_return_packet(7)]);
        set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
        drawnow();
        
    end
catch exception
    getReport(exception)
    disp('Exited on error, clean shutdown');
end
% Clear up memory upon termination
pp.shutdown()
toc;
clear