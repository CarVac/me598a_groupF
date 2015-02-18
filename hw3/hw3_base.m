%This is a basic script.

%Problem 1: 5-8
%Derive the equations needed to compute the shortest distance from point p
%to the line segment connecting p1 and p2.

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

%Problem 3: 5-13
%Write a computer program to implement the path planner described in
%section 5.2 for a 3-link planar arm moving among polygonal obstacles.

%Problem 4: 5-14
%Write a simple computer program to performan collision checking for the
%case of a polygonal robot moving in the plane among polygonal obstacles. 
%Your program should accept a configuration q [a vector] as input, and
%should return a value that indicates whether q is a collision-free
%configuration.

%Problem 5: 5-19
%Suppose we desire a joint space trajectory qdot^d_i(t) for the ith joint
%(revolute) that begins at rest at position q0 at time t0 and reaches
%position q1 in 2 seconds with a final velocity of 1 radian per second.
%Compute a cubic polynomial satisfying these constraints. Sketch the
%trajectory as a function of time.

%I bet we can easily write a program for that.

%Problem 6: 5-20
%Compute an LSPB trajectory to satisfy the same requirements as Problem
%5-19. Sketch the resulting position, velocity, and acceleration profiles.

%Problem 7: 5-22
%Write a Matlab m-file, lspb.m, to generate an LSPB trajectory, given
%appropriate initial data.

%Problem 8: 5-23
%Rewrite cubic, quintic, and lspb into Matlab functions.

%Well, we did cubic, it might as well have been a function. We can do
%quintic easily enough I think, and lspb might as well have been a function
%from the start.
%We must document them appropriately, as well.