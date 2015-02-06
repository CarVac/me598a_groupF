function [ out ] = DH_trans( a, alpha, d, theta )
ct = cos(theta);
st = sin(theta);
ca = cos(alpha);
sa = sin(alpha);
out = [ct, -st*ca, st*sa, a*ct;
       st, ct*ca, -ct*sa, a*st;
       0, sa, ca, d;
       0, 0, 0, 1];


end

