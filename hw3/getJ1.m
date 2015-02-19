%% Calculates position Jacobian for O1
function J1 = getJ1(q,a1)

theta1=q(1);

% O1 Jacobian
J1 = [-a1*sin(theta1) 0 0;
    a1*cos(theta1) 0 0];
