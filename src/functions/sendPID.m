%% send PID Server packet
function sendPID(pp, ID, packet)
    conversionFactor = 4096/360;
    packet(1) = packet(1) * conversionFactor;
    packet(4) = packet(4) * conversionFactor;
    packet(7) = packet(7) * conversionFactor;
    
    pp.write(ID, packet);
return