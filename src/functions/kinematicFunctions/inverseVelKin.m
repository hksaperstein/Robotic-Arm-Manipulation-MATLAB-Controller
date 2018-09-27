function [ positions ] = inverseVelKin(jacobian, velocity )
    velocity = velocity';
    jacobian = jacobian(1:3, 1:3);
    iJacobian = inv(jacobian);
    positions = iJacobian * velocity;

end

