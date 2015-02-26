%Lab 1 by Carlo Vaccari, Giovanni Notaro, and Yawei Tong

% link,     a       alpha       d       theta
% 1         0       90deg       67mm    theta1*
% 2         90mm    0           0       theta2*
% 3         78mm    0           0       theta3*
% 4         0       90deg       0       theta4*
% 5         0       0           142mm*  theta5*

%As a note:
%When joint 2 is 90, the arm is straight.
%When joint 2 is 0, the arm is bent 90 degrees.
%When joint 4 is 90, the arm is straight.
%When joint 4 is 0, the arm is bent 90 degrees.

%Example 1
%Straight up.
theta1 = 0;
theta2 = 90;
theta3 = 0;
theta4 = 90;
theta5 = 0;

transform = rais_transform([theta1, theta2, theta3, theta4, theta5]);

position = transform*[0;0;0;1];
%Result: [0; 0; 14.8425; 1]

%Example 2.
%Bent 90 degrees at joint 2 and straight elsewhere.
%This should stick out a good distance in x, and have much less z.
theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 90;
theta5 = 0;

transform = rais_transform([theta1, theta2, theta3, theta4, theta5]);

position2 = transform*[0;0;0;1];
%Result: [12.2047; 0; 2.6378; 1]

%Example 3
%Rotated 90 degrees clockwise at joint 1, bent 90 degrees at joint 2,
%straight elsewhere.
%This should stick out a good distance in y, and have much less z.
theta1 = 90;
theta2 = 0;
theta3 = 0;
theta4 = 90;
theta5 = 0;

transform = rais_transform([theta1, theta2, theta3, theta4, theta5]);

position3 = transform*[0;0;0;1]
%Result: [0; 12.2047; 2.6378; 1]

%Example 4
%Rotated 90 degrees clockwise at joint 1, bent 90 degrees at joint 2, bent
%90 degrees at joint 3, straight otherwise
%This should have a little y and a lot of z, but not maxxed out.
theta1 = 90;
theta2 = 0;
theta3 = 90;
theta4 = 90;
theta5 = 0;
transform = rais_transform([theta1, theta2, theta3, theta4, theta5]);

position4 = transform*[0;0;0;1]
%result: [0; 3.5433; 11.2292; 1]

%Example 5
%Rotated 45 degrees clockwise at joint 1, straight at joint 2, straight at
%joint 3, bent 90 degrees at joint 4, not rotated at joint 5
%This should have a moderate and equal x and y, and a good deal of z.
theta1 = 45;
theta2 = 90;
theta3 = 0;
theta4 = 0;
theta5 = 0;
transform = rais_transform([theta1, theta2, theta3, theta4, theta5]);

position5 = transform*[0;0;0;1]
%result: [3.9531; 3.9531; 9.2520; 1]

%Example 6
%Straight except for joints 3 and 4 which are both bent 90 degrees.
%This should have some x and some z.