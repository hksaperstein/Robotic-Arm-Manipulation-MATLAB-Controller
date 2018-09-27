function [forwardVel] = forwardVelKin(jacobian, jointVel)
    forwardVel = jacobian*jointVel';

end

