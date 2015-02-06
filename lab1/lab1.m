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

T1 = DH_trans(0, pi/2, 67/25.4, theta1*pi/180);
P1 = T1 * [0 0 0 1]'
T2 = DH_trans(90/25.4, 0, 0, theta2*pi/180);
P2 = T1 * T2 * [0 0 0 1]'
T3 = DH_trans(78/25.4, 0, 0, theta3*pi/180);
P3 = T1 * T2 * T3 * [0 0 0 1]'
T4 = DH_trans(0, pi/2, 0, theta4*pi/180);
P4 = T1 * T2 * T3 * T4 * [0 0 0 1]'
T5 = DH_trans(0, 0, 142/25.4, theta5*pi/180);

transform = T1*T2*T3*T4*T5;

position = transform*[0;0;0;1]