function [ centroid, color ] = imageProcess( image )
    %take image 
        %return a centroid and color (centroid is a 1x2 array, colour is a
        %string
        %if != empty -> return the centroid and color number
        %check for empty returned array

        [img2, img3] = createBlueMask(image);
       
        b = regionprops(img2, 'Centroid');
        [img6, img7] = createGreenMask(image);
        g = regionprops(img6, 'Centroid');
        [img4, img5] = createYellowMask(image);
        y = regionprops(img4, 'Centroid');
        
        bArray = struct2cell(b);
        gArray = struct2cell(g);
        yArray = struct2cell(y);
        %Check if blue has a centroid
        if (~isempty(bArray))
            centroid = b.Centroid;
            color = 'blue';
        %Check if green has a centroid 
        elseif (~isempty(gArray))
            centroid = g.Centroid;
            color = 'green';
        %Check if yellow has a centroid
        elseif (~isempty(yArray))
            centroid = y.Centroid;
            color = 'yellow';
        else
            centroid = [];
            color = 'none';
        end
        %return centroid and color (centroid is 1x2 array "X,Y" and color
        %is 1/2/3 for b/g/r 
        if(~strcmp('none',color))
            centroid = mn2xy(centroid(1), centroid(2));
        end
end

