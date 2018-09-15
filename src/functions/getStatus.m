%% return packet with angles in degrees
function [packet] = getStatus(pp,ID, status_packet)
    packet = pp.command(ID, status_packet);
    
    conversionFactor = 360/4096;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
return