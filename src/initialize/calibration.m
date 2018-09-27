pp.write(CALIBRATE_ID, calibrate_packet);
    
return_calibrate_matrix = zeros(11,15);

for i = (1:11)

    return_status_packet = getStatus(pp, STATUS_ID, status_packet);

    return_calibrate_matrix(i,:) = return_status_packet;

    pause(.2)
end

return_calibrate_matrix;
[calibration_matrix, force_matrix] = calibrate(return_calibrate_matrix);

conversionFactor = 4096/360;

calibrate_packet(1) = calibration_matrix(1) * conversionFactor;
calibrate_packet(4) = calibration_matrix(2) * conversionFactor;
calibrate_packet(7) = calibration_matrix(3) * conversionFactor;
calibrate_packet(3) = force_matrix(1);
calibrate_packet(6) = force_matrix(2);
calibrate_packet(9) = force_matrix(3);


pp.write(CALIBRATE_ID, calibrate_packet);