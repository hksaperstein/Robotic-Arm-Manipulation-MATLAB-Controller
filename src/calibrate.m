function offsets = calibrate(file)
    data = dlmread(file);
    [m,n] = size(data)
    data = sum(data);
    
    
    offsets = data([1 4 7]);
    offsets = offsets/(m-1);
    return
end
    
    
    
    
 