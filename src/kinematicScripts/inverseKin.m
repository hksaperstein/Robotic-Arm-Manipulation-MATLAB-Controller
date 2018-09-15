%% inverse kinematics

pos1 = ikin([175,0,-34.28])
pos2 = ikin([0,-344.28,135])

pid_packet(1) = pos2(1);
pid_packet(4) = pos2(2);
pp.write(PID_ID, pid_packet);
pid_packet(7) = pos2(3);
pp.write(PID_ID, pid_packet);

points = pose([return_pid_packet(1) return_pid_packet(4) return_pid_packet(7)]);
addpoints(path,double (points(1,4)), double (points(2,4)), double (points(3,4)));
drawnow();