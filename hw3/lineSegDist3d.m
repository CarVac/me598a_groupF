function [ distance ] = lineSegDist3d( p, p1, p2 )
%Finds shortest distance from point to a line segment in 3d
%   Detailed explanation goes here


%Basic ideas:
%Compute the angles p p1 p2 and p p2 p1
%If either is >90 degrees, then we pick the distance to that middle point.
%If neither is >90 degrees, we compute the distance normal to the infinite
%line connecting them.

%Another idea:
%Compute the projection of the point p onto the infinite line b/w p1 & p2.
%If that point is between the two, then compute the distance normal to the
%line.
%If that point is not between the two, then compute the distance to the
%nearest of the two.

%Vector perpendicular to the line segment
perpVector = cross(p2-p1,cross(p2-p1,p1-p));
%perpVector = [p2(2)-p1(2); p1(1)-p2(1)];%from 2d version
%Distance from p to p1
r1 = p1-p;
%Projection of r1 onto perpVector
r_proj = dot(r1,perpVector)*perpVector/(norm(perpVector)^2);
p_on_line = p + r_proj;

%Distance from p_on_line to p1 divided by distance from p
inside_ratio = (p_on_line - p1)./(p2 - p1);
%Both elements should be the same.

if(inside_ratio(1) < 0)%It's closer to p1 but not between p1 and p2
    distance = norm(p1-p);
    return;
elseif(inside_ratio(1) > 1)%It's closer to p2 but not between p1 and p2
    distance = norm(p2-p);
    return;
else%It's in the middle
    distance = norm(p_on_line-p);
    return;
end
end

