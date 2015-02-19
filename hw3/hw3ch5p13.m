clc;
clear all;
close all;

% Starting joint coordinate configuration
q_s = [0;0;0];

% Final (goal) joint coordinate configuration
q_f = [pi/2; pi/2; pi/2];

% Obstacle 1 Coordinates
obs1=[0 2;0.5 2;0.5 2.5;0 2.5];

Xobs = [obs1(:,1);obs1(1,1)];
Yobs = [obs1(:,2);obs1(1,2)];

% Plot Obstacles, and Manipulator Initial and Starting Configurations
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(4)*0.2 scrsz(4)*0.2 scrsz(3)*0.7 scrsz(4)*0.7]);
plot(Xobs, Yobs, 'r');
axis([-3 3.5 -0.9 3]);
axis equal;
hold on;

% Obstacle 2 Coordinates
obs2=[2.25 1.5; 2 0.5;2.5 1];

Xobs = [obs2(:,1);obs2(1,1)];
Yobs = [obs2(:,2);obs2(1,2)];

% Plot Obstacles, and Manipulator Initial and Starting Configurations
scrsz = get(0,'ScreenSize');
plot(Xobs, Yobs, 'r')

% Link lengths
a1 = 0.5;
a2 = 1;
a3 = 0.5;

% Plot Manipulator Starting Configuration
O1s = getO1(a1,q_s);
O2s = getO2(a1,a2,q_s);
O3s = getO3(a1,a2,a3,q_s);
Xlinks = [0 ;O1s(1); O2s(1); O3s(1)];
Ylinks = [0 ;O1s(2); O2s(2); O3s(2)];
plot(Xlinks, Ylinks,'kd-')

% Plot Manipulator Final (Goal) Configuration
O1f = getO1(a1,q_f);
O2f = getO2(a1,a2,q_f);
O3f = getO3(a1,a2,a3,q_f);
Xlinks = [0 ;O1f(1); O2f(1); O3f(1)];
Ylinks = [0 ;O1f(2); O2f(2); O3f(2)];
plot(Xlinks, Ylinks,'kd-')

% Attractive and Repulsive Field Parameters
eta = 0.15;              % controls the relative influence of the repulsive potential
self_eta1=1;          % controls the relative influence of the self repulsive potential
self_eta2=0.2;
zeta = 1.5;             % controls the relative influence of the attractive potential   
d = 0.6;                % distance that defines the transition from conic to parabolic attractive wells
rho_o = 0.3;            % distance of influence for obstacles
rho_1 = 0.5;            % distance of self influence 
rho_2 = 1.3;            % distance of self influence 
epsilon = 0.01;         % convergence tolerance

q_storage = [q_s];      % Initialize matrix of via points

q = q_s;
M = norm(q-q_f);
i = 0;
% Gradient Descent Algorithm from p.179
    while M > epsilon
        if(M < 0.5)%Adaptive step size
            alpha = 0.01;
        elseif(M<0.1)
            alpha = 0.001;
        elseif(M<0.01)
            alpha = 0.00001;
        else
            alpha = 0.1;
        end
        O1 = getO1(a1,q); 
        O2 = getO2(a1,a2,q); 
        O3 = getO3(a1,a2,a3,q); 
        
        %attraction to the joints
        F_att_1 = getF_att(O1,O1f,d,zeta); 
        F_att_2 = getF_att(O2,O2f,d,zeta)/4; 
        F_att_3 = getF_att(O3,O3f,d,zeta)/16; 
        
        %obstacle repulsion to the joints
        F_rep_1 = getF_rep(O1,obs1(:,1),obs1(:,2),eta,rho_o);
        F_rep_2 = getF_rep(O2,obs1(:,1),obs1(:,2),eta,rho_o);
        F_rep_3 = getF_rep(O3,obs1(:,1),obs1(:,2),eta,rho_o);
        F_rep_1_2 = getF_rep(O1,obs2(:,1),obs2(:,2),eta,rho_o);
        F_rep_2_2 = getF_rep(O2,obs2(:,1),obs2(:,2),eta,rho_o);
        F_rep_3_2 = getF_rep(O3,obs2(:,1),obs2(:,2),eta,rho_o);
        
        %repulsion between joints
        self_rep_02 = getF_rep(O2,0,0,self_eta1,rho_1);               % joint 2 and origin
        self_rep_03 = getF_rep(O3,0,0,self_eta1,rho_1);               % joint 3 and origin
        %midpoint fake joint between 1 and 2
        OM = O1+0.5*(O2-O1);
        self_rep_13 = getF_rep(O3,OM(1),OM(2),self_eta1,rho_1/5);       % joint 1 and 3
        
        J1 = getJ1(q,a1);       % Jacobian for O1 evaluated at q
        J2 = getJ2(q,a1,a2);    % Jacobian for O2 evaluated at q
        J3 = getJ3(q,a1,a2,a3); % Jacobian for O2 evaluated at q
        tau = J1'*F_att_1+J2'*F_att_2+J3'*F_att_3+J1'*(F_rep_1+F_rep_1_2)+...
            J2'*(F_rep_2+self_rep_02+F_rep_2_2)+...
            J3'*(F_rep_3+self_rep_03+self_rep_13+F_rep_3_2);  
        
        q_new = q + alpha*tau/norm(tau);        % Calculate new q
        q_storage = [q_storage q_new];          % Add q to q_storage array
        q = q_new;                              % update q for next iteration
        M = norm(q-q_f);                        % update M for next iteration
        
        Xlinks = [0 ;O1(1); O2(1); O3(1)];            
        Ylinks = [0 ;O1(2); O2(2); O3(2)];
        x1=plot(Xlinks(4), Ylinks(4),'bo');            % Plot link geometry at q
        x2=plot(Xlinks(3), Ylinks(3),'ko');
        x3=plot(Xlinks(2), Ylinks(2),'ro');
        x4=plot(Xlinks, Ylinks,'g-');

        pause(0.04);
%         delete(x1);
%         delete(x2);
%         delete(x3);
%         delete(x4);
        
        i=i+1
        M

    end
% Plot Manipulator Starting Configuration again
O1s = getO1(a1,q_s);
O2s = getO2(a1,a2,q_s);
O3s = getO3(a1,a2,a3,q_s);
Xlinks = [0 ;O1s(1); O2s(1); O3s(1)];
Ylinks = [0 ;O1s(2); O2s(2); O3s(2)];
plot(Xlinks, Ylinks,'ks--')

% Plot Manipulator Final (Goal) Configuration again
O1f = getO1(a1,q_f);
O2f = getO2(a1,a2,q_f);
O3f = getO3(a1,a2,a3,q_f);
Xlinks = [0 ;O1f(1); O2f(1); O3f(1)];
Ylinks = [0 ;O1f(2); O2f(2); O3f(2)];
plot(Xlinks, Ylinks,'kd--')
    
    