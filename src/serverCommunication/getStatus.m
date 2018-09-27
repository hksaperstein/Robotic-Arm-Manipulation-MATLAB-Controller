    %% return packet with angles in degrees
 function [packet] = getStatus(pp, ID, status_packet)
    packet = pp.command(ID, status_packet);
    format long g
    conversionFactor = 360/4096;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
    packet(3) = packet(3) * 4096;
    packet(6) = packet(6) * 4096;
    packet(9) = packet(9) * 4096;

    joint1TOffset = 1977.483;
    joint2TOffset = 1935.473;
    joint3TOffset = 1404.343; 
    k = 178.5;

    packet(3) = (packet(3) - joint1TOffset) / k;
    packet(6) = (packet(6) - joint2TOffset) / k;
    packet(9) = (packet(9) - joint3TOffset) / k;  
 return