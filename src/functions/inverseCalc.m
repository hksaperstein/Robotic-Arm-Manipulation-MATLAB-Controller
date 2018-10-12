function [ nextPos] = inverseCalc(currentPos, endPos)


    % coordPos = [[147 120 215]; [194 -147 20]; [135 67 -13]; [147 120 215]; [175 0 -34.28]]
    % totalTime = [1.5 3 2.5 3 3.5];
    % totalSteps = [15 30 25 30 50];
    %trajPoints = quinticTrajectoryPoints(totalTime, totalSteps, coordPos);
    
    ang = ikin(currentPos);
    jacobian = jacob0(ang);
    timeElapsed = .1;
    posVector = endPos - currentPos;
    posVector = posVector'
    posVector = posVector';
    velVector = posVector / (timeElapsed);
    angVel = inverseVelKin(jacobian, velVector);
    nextPos = ang + angVel' * (timeElapsed);
   
end

