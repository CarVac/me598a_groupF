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
%Hmmm...

end

