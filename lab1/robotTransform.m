function [ transform ] = robotTransform( theta1, theta2, theta3, theta4, theta5 )
% link,     a       alpha       d       theta
% 1         0       90deg       67mm    theta1*
% 2         90mm    0           0       theta2*
% 3         78mm    0           0       theta3*
% 4         0       90deg       0       theta4*
% 5         0       0           142mm*  theta5*

T1 = DH_trans(0, pi/2, 67/25.4, theta1*pi/180);
T2 = DH_trans(90/25.4, 0, 0, theta2*pi/180);
T3 = DH_trans(78/25.4, 0, 0, theta3*pi/180);
T4 = DH_trans(0, pi/2, 0, theta4*pi/180);
T5 = DH_trans(0, 0, 142/25.4, theta5*pi/180);

transform = T1*T2*T3*T4*T5;
end

