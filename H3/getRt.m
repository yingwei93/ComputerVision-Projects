function [newR1,t1] = getRt(H1,A)
%extrinsic parameters: R,t
[R1,t1] = computeRt(H1,A);
%new R and RTR
[U1,S1,V1] = svd(R1);
newR1 = U1 * V1';