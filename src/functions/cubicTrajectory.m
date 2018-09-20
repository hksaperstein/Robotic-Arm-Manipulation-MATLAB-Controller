function position = cubicTrajectory(a, time)
position = a(1) + a(2)*time + a(3)*time.^2 + a(4)*time.^3;

return
