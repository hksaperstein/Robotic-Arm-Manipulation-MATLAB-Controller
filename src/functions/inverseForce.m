function [tipForces] = inverseForce(torque, jacobian)
    jacobian = jacobian'
    jacobian = pinv(jacobian);
    tipForces = jacobian*torque';
return