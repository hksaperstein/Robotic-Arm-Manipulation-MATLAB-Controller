%% send PID Server packet
function [return_packet] = pidCom(pp, ID, packet)
    conversionFactor = 4096/360;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
    
    return_packet = pp.command(ID, packet);
    
    conversionFactor = 1/conversionFactor;
    return_packet(1) = return_packet(1) * conversionFactor;
    return_packet(4) = return_packet(4) * conversionFactor;
    return_packet(7) = return_packet(7) * conversionFactor;
return