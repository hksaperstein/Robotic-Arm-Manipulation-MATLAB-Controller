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

    joint1TOffset = 1966.0;
    joint2TOffset =  2072.6;
    joint3TOffset =  1901.2;
    k1 = 170.28;
    k2 = 155;
    k3 = 40;
    packet(3) = ((packet(3) - joint1TOffset) / k1);
    packet(6) = -((packet(6) - joint2TOffset) / k2);
    packet(9) = ((packet(9) - joint3TOffset) / k3);
 return
