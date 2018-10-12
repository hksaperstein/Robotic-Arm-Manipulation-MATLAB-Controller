function [tipForces] = inverseForce(torque, jacobian)
    jacobian = jacobian';
    tipForces = jacobian \ torque';
    tipForces = tipForces';
return