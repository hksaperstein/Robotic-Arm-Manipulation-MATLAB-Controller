function offsets = calibrate(matrix)
    
    [r, c] = size(matrix);
    matrix = sum(matrix);
    
    
    offsets = matrix([1 4 7]);
    offsets = offsets/(r - 1);
    return
end
    
    
    
    
 