%% Takes in single path time, path steps, startposition and endposition

function [ points ] = quinticTrajectoryPoints( totalTime, totalSteps, startPosition, endPosition )
    x = 1;
    y = 2;
    z = 3;

    
   
    constantValuesX = quinticPoly(startPosition(x), endPosition(x), 0, totalTime, 0, 0, 0, 0);
    constantValuesY = quinticPoly(startPosition(y), endPosition(y), 0, totalTime, 0, 0, 0, 0);
    constantValuesZ = quinticPoly(startPosition(z), endPosition(z), 0, totalTime, 0, 0, 0, 0);
    
    row = 0;
    time = 0;
    points = zeros(totalSteps, 3);
    for j = 1:totalSteps
        time = time + (totalTime/totalSteps);
        xPos = quinticTrajectory(constantValuesX, time)
        yPos = quinticTrajectory(constantValuesY, time)
        zPos = quinticTrajectory(constantValuesZ, time)
        row = row + 1;
        points(row,:) = ikin([xPos yPos zPos]); 
        
    end
    
% returns 2D array of step set points in cartesian
return

