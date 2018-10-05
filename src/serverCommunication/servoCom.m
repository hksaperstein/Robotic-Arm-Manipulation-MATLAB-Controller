    %% Sends packet with value to open or close tip servo
		%% value of 0 = close, value of 1 = open
 function [packet] = servoCom(pp, ID, servo_packet, selectionValue)
    packet = pp.command(ID, servo_packet);
    packet(1) = packet(1) * selectionValue;
 return
