function [R,t] = computeRt(H,A)
lambda = 1/norm(inv(A)*H(:,1));
r1 = lambda * A^(-1) * H(:,1);
r2 = lambda * A^(-1) * H(:,2);
r3 = cross(r1,r2);
t = lambda * A^(-1) * H(:,3);
R = [r1,r2,r3];
end