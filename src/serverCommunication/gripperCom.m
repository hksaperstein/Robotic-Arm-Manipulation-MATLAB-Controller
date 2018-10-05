    %% Sends packet with value to open or close tip servo
		
 function [packet] = gripperCom(pp, ID, gripper_packet, selectionValue)
%     value of 0 = close, value of 1 = open   
    gripper_packet(1) = selectionValue;
    packet = pp.command(ID, gripper_packet);

   % packet(1) = packet(1) * selectionValue;
 return
