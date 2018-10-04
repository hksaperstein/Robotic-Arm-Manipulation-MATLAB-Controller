function [tipForces] = inverseForce(torque, jacobian)
    jacobian = jacobian';
    jacobian = inv(jacobian);
    tipForces = jacobian*torque';
return