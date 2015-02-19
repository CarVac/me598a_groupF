%% Calculates position Jacobian for O2
function J3 = getJ3(q,a1,a2,a3)

theta1=q(1);
theta2=q(2);
theta3=q(3);

% O2 Jacobian

J3 = [- a2*sin(theta1 + theta2) - a1*sin(theta1) - a3*sin(theta1 + theta2 + theta3), - a2*sin(theta1 + theta2) - a3*sin(theta1 + theta2 + theta3), -a3*sin(theta1 + theta2 + theta3);
    a2*cos(theta1 + theta2) + a1*cos(theta1) + a3*cos(theta1 + theta2 + theta3),   a2*cos(theta1 + theta2) + a3*cos(theta1 + theta2 + theta3),  a3*cos(theta1 + theta2 + theta3)];