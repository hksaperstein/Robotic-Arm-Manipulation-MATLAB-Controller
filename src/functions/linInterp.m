function [points] = linInterp(pos1, pos2)
    px1 = pos1(1);
    py1 = pos1(2);
    pz1 = pos1(3);

    px2 = pos2(1);
    py2 = pos2(2);
    pz2 = pos2(3);

    diffx = px2 - px1;
    diffy = py2 - py1;
    diffz = pz2 - pz1;

    diffx = diffx/20;
    diffy = diffy/20;
    diffz = diffz/20;
    
    points = zeros(20,3)
    for i = 1:20
        px1 = px1 + diffx;
        py1 = py1 + diffy;
        pz1 = pz1 + diffz;
        points(i,:) = [px1 py1 pz1];
    end
    points
return