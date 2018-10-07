function [ centroid, color ] = Untitled( image )
    %take image 
        %return a centroid and color (centroid is a 1x2 array, colour is a
        %string
        %if != empty -> return the centroid and color number
        %check for empty returned array

        [img2, img3] = createBlueMask(image);
        b = regionProps(img2, 'centroid');
        [img6, img7] = createGreenMask(image);
        g = regionProps(img6, 'centroid');
        [img4, img5] = createYellowMask(image);
        y = regionProps(img4, 'centroid');
        %Check if blue has a centroid
        if (~isempty(b.Centroid))
            centroid = b.Centroid;
            color = 'blue';
        %Check if green has a centroid 
        elseif (~isempty(g.Centroid))
            centroid = g.Centroid;
            color = 'green';
        %Check if yellow has a centroid
        elseif (~isempty(y.Centroid))
            centroid = y.centroid
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

