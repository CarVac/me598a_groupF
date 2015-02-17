% link,     a       alpha       d       theta
% 1         0       90deg       67mm    theta1*
% 2         90mm    0           0       theta2*
% 3         78mm    0           0       theta3*
% 4         0       90deg       0       theta4*
% 5         0       0           142mm*  theta5*

theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;
theta5 = 0;

transform = robotTransform(theta1, theta2, theta3, theta4, theta5);

position = transform*[0;0;0;1]