function [values] = quinticPoly(startP, endP, startT, endT, startV, endV, startA, endA)
    equationsMatrix = [1 startT (startT^2) (startT^3) (startT^4) (startT^5);
                       0 1 (2*startT) (3*startT^2) (4*startT^3) (5*startT^4);
                       0 0 2 (6*startT) (12 * startT^2) (20*startT^3);
                       1 endT (endT^2) (endT^3) (endT^4) (endT^5);
                       0 1 (2*endT) (3*endT^2) (4*endT^3) (5*endT^4);
                       0 0 2 (6*endT) (12*endT^2) (20*endT^3)];
                  
    equationsMatrix = inv(equationsMatrix);
    
    values = equationsMatrix * [startP; startV; startA; endP;  endV; endA];
    values = values';