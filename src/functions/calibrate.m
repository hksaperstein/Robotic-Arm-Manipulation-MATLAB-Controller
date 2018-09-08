function offsets = calibrate(matrix)
    
    [m,n] = size(matrix);
    matrix = sum(matrix);
    
    
    offsets = matrix([1 4 7]);
    offsets = offsets/(m-1);
    return
end
    
    
    
    
 