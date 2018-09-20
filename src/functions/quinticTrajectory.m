function position = quinticTrajectory(a, time)
    position = a(1) + a(2)*time + a(3)*time^2 + a(4)*time^3 + a(5)*time^4 + a(6)*time^5;
return
