function [angles] = ikin(position)
px = position(1);
py = position(2);
pz = position(3);

sym (pi);

l1 = 135;
l2 = 175;
l3 = 169.28;
l4 = sqrt((px^2)+(py^2)+((pz-l1)^2));


    if (l4 > l2 + l3 || l4 < l2 - l3) || (pz < -34.28) || (px < 0) 
        msg = 'Outside Normal Range';
        error(msg)
    else
        
        alpha = atan2((pz-l1),(sqrt((px^2)+(py^2))));
        beta = acos(((l2^2)+(l4^2)-(l3^2))/(2*l2*l4));    
        theta1 = atan2(py,px);
        theta2 = (alpha + beta);
        theta3 = (-pi/2 + acos(((l2^2)+(l3^2)-(l4^2))/(2*l2*l3)));
        angles = [theta1, theta2, theta3] * (180/pi);
    end

end

