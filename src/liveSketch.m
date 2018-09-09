
    figure1 = figure;
    hold on;
    grid on;
    points = pose([0 0 0]);
    R.handle = plot3(points(1,:),points(2,:),points(3,:),'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[0 0 1],...
    'Marker','o',...
    'Color',[0 1 0]);

    hold on;
    grid on;
    view(3);
    axis([-150 350 -250 250 -100 400]);
    status_return_packet = pp.command(STATUS_ID, status_packet);

    points = pose([status_return_packet(1) status_return_packet(4) status_return_packet(7)]);

    set(R.handle, 'xdata', points(1,:), 'ydata', points(2,:),'zdata', points(3,:));
    drawnow();
        
        
