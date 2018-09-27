function [ points ] = jointVelocityDeterm( startPositions, endPositions, timeStep, jacobian )

    startx = startPositions(1);
    starty = startPositions(2);
    startz = startPositions(3);

    endx = endPositions(1);
    endy = endPositions(2);
    endz = endPositions(3);

    velocx = (endx-startx)/timeStep;
    velocy = (endy-starty)/timeStep;
    velocz = (endz-startz)/timeStep;

    angularVel = inverseVelKin(jacobian,[velocx, velocy, velocz]);
    angularVel = angularVel';
    points = [angularVel(1), angularVel(2), angularVel(3)];

end
