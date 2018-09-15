%% inverse kinematics

pos1 = ikin([175,0,-34.28])
pos2 = ikin([0,0,479.28])

pid_packet(1) = pos2(1);
pid_packet(4) = pos2(2);
pp.write(PID_ID, pid_packet);
pause(5);
pid_packet(7) = pos2(3);
pp.write(PID_ID, pid_packet);