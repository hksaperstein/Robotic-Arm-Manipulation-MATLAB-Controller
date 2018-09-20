function [values] = cubicPoly(startP, endP, startT, endT, startV, endV)
    equationsMatrix = [1 startT power(startT,2) power(startT, 3); 
                       0 1 2*startT 3*power(startT,3); 
                       1 endT power(endT, 2) power(endT, 3);
                       0 1 2*endT 3*power(endT,3)];
                  
    equationsMatrix = inv(equationsMatrix);
    
    values = equationsMatrix * [startP; startV; endP;  endV];
    values = values';
return