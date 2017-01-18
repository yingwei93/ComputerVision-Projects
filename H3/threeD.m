diary 3D.txt
%1.image points
camera = [422 323;178 323;118 483; 482 483; 438 73; 162 73; 78 117;522 117];
plot(camera(:,1),camera(:,2),'o');

%2/3.get P
camera2 = [422 323;178 323;118 483; 482 483; 438 73; 162 73; 78 117;522 117]';
cube = [2 2 2; -2 2 2; -2 2 -2; 2 2 -2; 2 -2 2; -2 -2 2; -2 -2 -2; 2 -2 -2]';
size1 = size(cube,2);
homocube = [cube; ones(1,size1)];
size2 = size(camera2,2);
homocamera = [camera2; ones(1,size2)];
P = NaN(16, 12);
for i= 1:8
    a = homocube(:,i);
    b = homocamera(:,i);
    P((2*i-1):2*i,:) = getP(a, b);
end
P

%4.getM
[U,S,V] = svd(P);
m = V(:,12);
M = reshape(m,4,3)'

%5.Euclidean coordinates of the camera center
[U1,S1,V1] = svd(M);
v1 = V1(:,4);
cameracenter = v1/V1(4,4);
cameracenter(1:3,:)

%6.Mprime
Mprime = M(:,1:3);
Mprime = Mprime/M(3,3)

%7.RQ factorization
cosx = Mprime(3,3)/sqrt(Mprime(3,3)^2+Mprime(3,2)^2);
sinx = -Mprime(3,2)/sqrt(Mprime(3,3)^2+Mprime(3,2)^2);
Rx = [1,0,0;
      0,cosx,-sinx;
      0,sinx,cosx]
Thetax = asin(sinx)
N = Mprime*Rx

%8.Rz
cosz = N(2,2)/sqrt(N(2,1)^2 + N(2,2)^2);
sinz = -N(2,1)/sqrt(N(2,1)^2 + N(2,2)^2);
Rz = [cosz, -sinz, 0;
      sinz, cosz,  0;
      0, 0, 1]
Thetaz = asin(sinz)

%9.K
K = Mprime * Rx * Rz;
K = K/K(3,3)
diary off