function [ nextPos ] = inverseCalc(currentPos, endPos)


    % coordPos = [[147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]; [175 0 -34.28]]
    % totalTime = [1.5 3 2.5 3 3.5];
    % totalSteps = [15 30 25 30 50];
    %trajPoints = quinticTrajectoryPoints(totalTime, totalSteps, coordPos);
    points = ikin(currentPos);
    jacobian = jacob0(points);
    timeElapsed = 10;
    posVector = endPos - currentPos;
    velVector = posVector / (timeElapsed);
    angVel = inverseVelKin(pinv(jacobian), velVector);
    nextPos = points + angVel' * (timeElapsed);
end

