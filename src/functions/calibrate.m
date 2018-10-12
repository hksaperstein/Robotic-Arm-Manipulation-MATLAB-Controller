function [offsets, forceOffsets] = calibrate(matrix)
    
    [r, c] = size(matrix);
    matrix = sum(matrix);
    
    
    offsets = matrix([1 4 7]);
    offsets = offsets/(r - 1);
    forceOffsets = matrix([3 6 9]);
    forceOffsets = forceOffsets/(r-1);
    return
end
    
    
    
 