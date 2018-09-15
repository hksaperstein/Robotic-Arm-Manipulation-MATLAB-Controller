%% return packet with angles in degrees
function [packet] = getStatus(pp)
    packet = pp.read(STATUS_ID);
    
    conversionFactor = 360/4096;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
return