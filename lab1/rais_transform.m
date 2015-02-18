function [ out ] = rais_transform( thetas )
%Generates the robot's homogeneous transform given angles in degrees
% The input should be one 5-element row vector.

% link,     a       alpha       d       theta
% 1         0       90deg       67mm    theta1*
% 2         90mm    0           0       theta2*
% 3         78mm    0           0       theta3*
% 4         0       90deg       0       theta4*
% 5         0       0           142mm*  theta5*
if(size(thetas)~=[1 5])
    display('Input must be a 5-element row vector')
    out = zeros(4);
    return;
end
bounds = [ 90   90      90   90   90;
          -90  -30    -120  -30  -90];
if(sum(thetas>bounds(1,:))+sum(thetas<bounds(2,:)))%programming trick
    display('Joint value out of bounds')
    out = zeros(4);%return a blank 4x4 matrix
    return
end
theta1 = deg2rad(thetas(1));
theta2 = deg2rad(thetas(2));
theta3 = deg2rad(thetas(3));
theta4 = deg2rad(thetas(4));
theta5 = deg2rad(thetas(5));


T1 = DH_trans(0, pi/2, 67/25.4, theta1);
T2 = DH_trans(90/25.4, 0, 0, theta2);
T3 = DH_trans(78/25.4, 0, 0, theta3);
T4 = DH_trans(0, pi/2, 0, theta4);
T5 = DH_trans(0, 0, 142/25.4, theta5);

out = T1*T2*T3*T4*T5;

end

