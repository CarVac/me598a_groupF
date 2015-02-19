%% Evaluates O2 for configuration q
function O3 = getO3(a1,a2,a3,q)

theta1 = q(1);
theta2 = q(2);
theta3 = q(3);
O3 = [a1*cos(theta1)+a2*cos(theta1+theta2)+a3*cos(theta1+theta2+theta3);
    a1*sin(theta1)+a2*sin(theta1+theta2)+a3*sin(theta1+theta2+theta3)];
