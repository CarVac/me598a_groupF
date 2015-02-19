function [ distance ] = hw3ch5p10( point, polygon )
%Takes in one 3d point and an ordered vector of points forming a polygon,
%and returns the shortest distance between that point and the polygon.
%   The polygon must be represented as a row vector of column vectors; the
%   column vectors are each individual point.

%Problem 2: 5-10
%Derive the equations needed to compute the shortest distance from point p
%to the polygon in 3 dimensions with vertices a_i, i = 1...n.
%We have to use the second approach from the first problem: project the
%point p onto the plane that the polygon lies in, and then determine if the
%polygon contains the point.
%The latter is a bit complicated, though, since we have to deal with
%non-convex polygons: we have to check the angles of each corner or
%something to make sure that we're not scanning regions outside the
%polygon.


%First, let's determine the normal to the polygon.
%We can do this by taking the cross product of two adjacent sides of the
%polygon.
%We know that the polygon has >3 sides, so we can go from 1 to 2 and 2 to
%3.
normVector = cross(polygon(:,1)-polygon(:,2),polygon(:,3)-polygon(:,2));

%Vector from point in question to the first point of the polygon
r1 = polygon(:,1)-point;

%Projection of r1 onto normVector to get the vector pointing to the plane
%containing the polygon.
r_proj = dot(r1, normVector)*normVector/(norm(normVector)^2);
point_on_plane = point + r_proj;

%Now we need to find out whether the point is inside the polygon or not.
%First, pick the direction with the least range, and ignore that dimension.
minRange = min(range(polygon'))
if(range(polygon(1,:)) == minRange)
    poly2 = polygon(2:3,:);
    point2 = point_on_plane(2:3);
elseif(range(polygon(2,:)) == minRange)
    poly2 = [polygon(1,:);polygon(3,:)];
    point2 = [point_on_plane(1);point_on_plane(3)];
else
    poly2 = polygon(1:2,:);
    point2 = point_on_plane(1:2);
end

%Next, we need to compute the number of circlings.
polyCount = size(polygon,2);
sum = 0;
for i = 1:polyCount
    j = 1+i;
    if(i>polyCount)
        i = i - polyCount;
    end
    if(j>polyCount)
        j = j - polyCount;
    end
    p1 = poly2(:,i);
    p2 = poly2(:,j);
    
    perpVector = [p2(2)-p1(2); p1(1)-p2(1)];
    %Distance from p to p1
    r1 = p1-point2;
    %Projection of r1 onto perpVector
    r_proj = dot(r1,perpVector)*perpVector/(norm(perpVector)^2);
    p_on_line = point2 + r_proj;
    
    val = acos(dot(p1-point2,p2-point2)/...
        (norm(p1-point2)*norm(p2-point2)));
    
    if(abs(p2(2)-p1(2))>abs(p2(1)-p1(1)))%more vertical than horizontal
        if(p_on_line(1)>point2(1))%the line segment is to the right
            if(p2(2)>p1(2))%cw
                sum = sum + val;
            elseif(p2(2)<p1(2))%ccw
                sum = sum - val;
            end
        else
            if(p2(2)<p1(2))%cw
                sum = sum + val;
            else%ccw
                sum = sum - val;
            end
        end
    else %more horizontal than vertical
        if(p_on_line(2)>point2(2))%the line segment is above
            if(p2(1)>p1(2))%rightward (ccw)
                sum = sum - val;
            else
                sum = sum + val;
            end
        else
            if(p2(1)<p1(1))%leftward (cw)
                sum = sum - val;
            else
                sum = sum + val;
            end
        end
    end
    %sum = sum + val;
    %if(val >= 0)%check if it's negative, and if so, negate the acos
    %    sum = sum + acos(dot(poly2(:,i)-point2,poly2(:,j)-point2)/...
    %    (norm(poly2(:,i)-point2)*norm(poly2(:,j)-point2)));
    %else
    %    sum = sum + acos(dot(poly2(:,i)-point2,poly2(:,j)-point2)/...
    %    (norm(poly2(:,i)-point2)*norm(poly2(:,j)-point2)));
    %end
end
%This sum will be zero if the point is outside the polygon.
epsilon = 0.01;%radians
if(abs(sum) < epsilon) %outside the polygon or really really close
    %pick the shortest distance to any of the line segments forming it.
    distance = lineSegDist3d(point,polygon(:,1),polygon(:,2));
    for i = 2:polyCount
        j = 1+i;
        if(j>polyCount)
            j = j - polyCount;
        end
        dist2 = lineSegDist3d(point,polygon(:,i),polygon(:,j));
        if(dist2 < distance)
            distance = dist2;
        end
    end
    return;
else %inside the polygon
    %just get the distance between point_on_plane and point
    distance = norm(point_on_plane-point);
    return;
end
end

