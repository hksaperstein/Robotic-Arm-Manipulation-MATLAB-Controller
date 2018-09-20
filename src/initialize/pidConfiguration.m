%% PID Values Configuration
    % Joint 1
    pid_config_packet(1) = .0025; %joint1P
    %pid_config_packet(2) = 0; %joint1I
    pid_config_packet(3) = .025;  %joint1D
    
    % Joint 2
    pid_config_packet(4) = .0015;  %joint2P
    pid_config_packet(5) = .001;  %joint2I
    pid_config_packet(6) = .065; %joint2D

    % Joint 3
    pid_config_packet(7) = .005; %joint3P
    %pid_config_packet(8) = i; %joint3I
    pid_config_packet(9) = .035; %joint3D

    pp.write(PID_CONFIG_ID, pid_config_packet);