    %% return packet with angles in degrees
 function [packet] = statusCom(pp, ID, status_packet)
    packet = pp.command(ID, status_packet);
    format long g;
    conversionFactor = 360/4096;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
    packet(3) = packet(3) * 4096;
    packet(6) = packet(6) * 4096;
    packet(9) = packet(9) * 4096;

    joint1TOffset = 1982.784;
    joint2TOffset =  2064.804;
    joint3TOffset =  1908.066;
%     k1 = 170.28
%     k2 = 1.71;
%     k3 = 
      k = 178.5
    packet(3) = (packet(3) - joint1TOffset) / k;
    packet(6) = (packet(6) - joint2TOffset) / k;
    packet(9) = (packet(9) - joint3TOffset) / k;  
 return