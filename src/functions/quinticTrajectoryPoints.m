function [ points ] = quinticTrajectoryPoints( totalTime, totalSteps, positions )


start1x = positions(1, 1);
start1y = positions(1, 2);
start1z = positions(1, 3);

points = zeros(sum(totalSteps), 3);
[m,n] = size(positions);
row = 1;
for k = 1:(m - 1)
    timer = tic;
    constantValuesX = quinticPoly(start1x, positions(k+1, 1), 0, totalTime(k), 0, 0, 0, 0);
    constantValuesY = quinticPoly(start1y, positions(k+1, 2), 0, totalTime(k), 0, 0, 0, 0);
    constantValuesZ = quinticPoly(start1z, positions(k+1, 3), 0, totalTime(k), 0, 0, 0, 0);
    
    for j = 1:totalSteps(k)
        time = toc(timer);
        xPos = quinticTrajectory(constantValuesX, time);
        yPos = quinticTrajectory(constantValuesY, time);
        zPos = quinticTrajectory(constantValuesZ, time);
        points(row,:) = ikin([xPos yPos zPos]);
        pause(totalTime(k)/totalSteps(k));
        row = row +1;
    end
    start1x = positions(k+1, 1);
    start1y = positions(k+1, 2);
    start1z = positions(k+1, 3);
end

