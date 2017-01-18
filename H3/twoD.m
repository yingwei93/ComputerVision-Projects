diary 2D.txt
close all, clear all
%1.Corner Extraction and Homography computation
grid3 = [0,0,1; 
         270,0,1; 
         270,210,1; 
         0,210,1]';

im1 = imread('images2.png');
figure();
imshow(im1);
[x,y] = ginput(4);
grid2 = [x';y';ones(1,4)];
H1 = homography2d(grid3,grid2)

im2 = imread('images9.png');
figure();
imshow(im2);
[x,y] = ginput(4);
grid21 = [x';y';ones(1,4)];
H2 = homography2d(grid3,grid21)

im3 = imread('images12.png');
figure();
imshow(im3);
[x,y] = ginput(4);
grid22 = [x';y';ones(1,4)];
H3 = homography2d(grid3,grid22)

im4 = imread('images20.png');
figure();
imshow(im4);
[x,y] = ginput(4);
grid23 = [x';y';ones(1,4)];
H4 = homography2d(grid3,grid23)

%2.Computing the Intrinsic and Extrinsic parameters
V1 = computeV(H1);
V2 = computeV(H2);
V3 = computeV(H3);
V4 = computeV(H4);
V = [V1;V2;V3;V4];
[u,s,v] = svd(V);
b = v(:,end);
%B
B = [b(1) b(2) b(4);
     b(2) b(3) b(5);
     b(4) b(5) b(6)]
%intrinsic parameters
v0 = (B(1,2)*B(1,3)-B(1,1)*B(2,3))/(B(1,1)*B(2,2)-B(1,2)^2)
lambda = B(3,3)-(B(1,3)^2+v0*(B(1,2)*B(1,3)-B(1,1)*B(2,3)))/B(1,1)
alpha = sqrt(lambda/B(1,1))
beta = sqrt(lambda*B(1,1)/(B(1,1)*B(2,2)-B(1,2)^2))
gamma = -B(1,2)*alpha^2*beta/lambda
u0 = gamma*v0/alpha-B(1,3)*alpha^2/lambda
A = [alpha gamma u0; 0 beta v0; 0 0 1];
%extrinsic parameters: R,t
[R1,t1] = computeRt(H1,A);
R1 = R1
t1 = t1
RTR1 = R1'*R1
[R2,t2] = computeRt(H2,A);
R2 = R2
t2 = t2
RTR2 = R2'*R2
[R3,t3] = computeRt(H3,A);
R3 = R3
t3 = t3
RTR3 = R3'*R3
[R4,t4] = computeRt(H4,A);
R4 = R4
t4 = t4
RTR4 = R4'*R4
%new R and RTR
[U1,S1,V1] = svd(R1);
newR1 = U1 * V1'
newRTR1 = newR1' * newR1

[U2,S2,V2] = svd(R2);
newR2 = U2 * V2'
newRTR2 = newR2' * newR2

[U3,S3,V3] = svd(R3);
newR3 = U3 * V3'
newRTR3 = newR3' * newR3

[U4,S4,V4] = svd(R4);
newR4 = U4 * V4'
newRTR4 = newR4' * newR4

%3.improving accuracy
%Projected grid corners
gridx = 0:30:270;
gridy = 0:30:210;
Corners = zeros(2,80);
Corners = [Corners;ones(1,80)];
for i=1:8
    Corners(1,(i-1)*10+1:10*i) = gridx;
    Corners(2,(i-1)*10+1:10*i) = gridy(i);
end

p_approx1 = zeros(3,80);    
p_approx1 = H1*Corners;
temp = repmat(p_approx1(3,:),[3,1]);
p_approx1 = p_approx1./temp;
figure();
imshow(im1);
title('Projected grid corners1');
hold on
plot(p_approx1(1,:),p_approx1(2,:),'o');
hold off;

p_approx2 = zeros(3,80);    
p_approx2 = H2*Corners;
temp = repmat(p_approx2(3,:),[3,1]);
p_approx2 = p_approx2./temp;
figure();
imshow(im2);
title('Projected grid corners2');
hold on
plot(p_approx2(1,:),p_approx2(2,:),'o');
hold off;

p_approx3 = zeros(3,80);    
p_approx3 = H3*Corners;
temp = repmat(p_approx3(3,:),[3,1]);
p_approx3 = p_approx3./temp;
figure();
imshow(im3);
title('Projected grid corners3');
hold on
plot(p_approx3(1,:),p_approx3(2,:),'o');
hold off;

p_approx4 = zeros(3,80);    
p_approx4 = H4*Corners;
temp = repmat(p_approx4(3,:),[3,1]);
p_approx4 = p_approx4./temp;
figure();
imshow(im4);
title('Projected grid corners4');
hold on
plot(p_approx4(1,:),p_approx4(2,:),'o');
hold off;

%Harris corners
[cim1, r1, c1, rsubp1, csubp1] = harris(rgb2gray(im1), 2, 500, 2, 0);
[cim2, r2, c2, rsubp2, csubp2] = harris(rgb2gray(im2), 2, 500, 2, 0);
[cim3, r3, c3, rsubp3, csubp3] = harris(rgb2gray(im3), 2, 500, 2, 0);
[cim4, r4, c4, rsubp4, csubp4] = harris(rgb2gray(im4), 2, 500, 2, 0);
figure();
imshow(rgb2gray(im1));
title('Harris corners1');
hold on;
plot(csubp1,rsubp1,'+');

figure();
imshow(rgb2gray(im2));
title('Harris corners2');
hold on;
plot(csubp2,rsubp2,'+');

figure();
imshow(rgb2gray(im3));
title('Harris corners3');
hold on;
plot(csubp3,rsubp3,'+');

figure();
imshow(rgb2gray(im4));
title('Harris corners4');
hold on;
plot(csubp4,rsubp4,'+');

%closest Harris corner to each approximate grid corner
dist1 = dist2([csubp1,rsubp1], p_approx1(1:2,:)');
[Y,I] = sort(dist1);
p_correct1 = [];
for i=1:80
    p_correct1 = [p_correct1;csubp1(I(1,i)),rsubp1(I(1,i))];
end
p_correct1 = p_correct1';
figure();
imshow(im1);
title('grid points1');
hold on;
plot(p_correct1(1,:), p_correct1(2,:),'+');

dist22 = dist2([csubp2,rsubp2], p_approx2(1:2,:)');
[Y,I] = sort(dist22);
p_correct2 = [];
for i=1:80
    p_correct2 = [p_correct2;csubp2(I(1,i)),rsubp2(I(1,i))];
end
p_correct2 = p_correct2';
figure();
imshow(im2);
title('grid points2');
hold on;
plot(p_correct2(1,:), p_correct2(2,:),'+');

dist3 = dist2([csubp3,rsubp3], p_approx3(1:2,:)');
[Y,I] = sort(dist3);
p_correct3 = [];
for i=1:80
    p_correct3 = [p_correct3;csubp3(I(1,i)),rsubp3(I(1,i))];
end
p_correct3 = p_correct3';
figure();
imshow(im3);
title('grid points3');
hold on;
plot(p_correct3(1,:), p_correct3(2,:),'+');

dist4 = dist2([csubp4,rsubp4], p_approx4(1:2,:)');
[Y,I] = sort(dist4);
p_correct4 = [];
for i=1:80
    p_correct4 = [p_correct4;csubp4(I(1,i)),rsubp4(I(1,i))];
end
p_correct4 = p_correct4';
figure();
imshow(im4);
title('grid points4');
hold on;
plot(p_correct4(1,:), p_correct4(2,:),'+');

%a new homography from p_correct
p_correct1 = [p_correct1;ones(1,80)];
p_correct2 = [p_correct2;ones(1,80)];
p_correct3 = [p_correct3;ones(1,80)];
p_correct4 = [p_correct4;ones(1,80)];
H1_correct = homography2d(Corners,p_correct1);
H2_correct = homography2d(Corners,p_correct2);
H3_correct = homography2d(Corners,p_correct3);
H4_correct = homography2d(Corners,p_correct4);

H1_correct = H1_correct./H1_correct(3,3)
H2_correct = H2_correct./H2_correct(3,3)
H3_correct = H3_correct./H3_correct(3,3)
H4_correct = H4_correct./H4_correct(3,3)

%estimate K and R, t
newV1 = computeV(H1_correct);
newV2 = computeV(H2_correct);
newV3 = computeV(H3_correct);
newV4 = computeV(H4_correct);
newV = [newV1;newV2;newV3;newV4];
[newu,news,newv] = svd(newV);
newb = newv(:,end);
newB = [newb(1) newb(2) newb(4);
        newb(2) newb(3) newb(5);
        newb(4) newb(5) newb(6)];
%K:A
newv0 = (newB(1,2)*newB(1,3)-newB(1,1)*newB(2,3))/(newB(1,1)*newB(2,2)-newB(1,2)^2);
newlambda = newB(3,3)-(newB(1,3)^2+newv0*(newB(1,2)*newB(1,3)-newB(1,1)*newB(2,3)))/newB(1,1);
newalpha = sqrt(newlambda/newB(1,1));
newbeta = sqrt(newlambda*newB(1,1)/(newB(1,1)*newB(2,2)-newB(1,2)^2));
newgamma = -newB(1,2)*newalpha^2*newbeta/newlambda;
newu0 = newgamma*newv0/newalpha-newB(1,3)*newalpha^2/newlambda;
newA = [newalpha newgamma newu0; 0 newbeta newv0; 0 0 1]
%R,t
[cnewR1,cnewt1] = getRt(H1_correct,newA);
cnewR1 = cnewR1
cnewt1 = cnewt1
[cnewR2,cnewt2] = getRt(H2_correct,newA);
cnewR2 = cnewR2
cnewt2 = cnewt2
[cnewR3,cnewt3] = getRt(H3_correct,newA);
cnewR3 = cnewR3
cnewt3 = cnewt3
[cnewR4,cnewt4] = getRt(H4_correct,newA);
cnewR4 = cnewR4
cnewt4 = cnewt4


%error
newp_approx1 = zeros(3,80);    
newp_approx1 = H1_correct*Corners;
temp = repmat(newp_approx1(3,:),[3,1]);
newp_approx1 = newp_approx1./temp;
err_reprojection1 = max(sqrt(sum((p_correct1 - newp_approx1).^2)/80))

newp_approx2 = zeros(3,80);    
newp_approx2 = H2_correct*Corners;
temp = repmat(newp_approx2(3,:),[3,1]);
newp_approx2 = newp_approx2./temp;
err_reprojection2 = max(sqrt(sum((p_correct2 - newp_approx2).^2)/80))

newp_approx3 = zeros(3,80);    
newp_approx3 = H3_correct*Corners;
temp = repmat(newp_approx3(3,:),[3,1]);
newp_approx3 = newp_approx3./temp;
err_reprojection3 = max(sqrt(sum((p_correct3 - newp_approx3).^2)/80))

newp_approx4 = zeros(3,80);    
newp_approx4 = H4_correct*Corners;
temp = repmat(newp_approx4(3,:),[3,1]);
newp_approx4 = newp_approx4./temp;
err_reprojection4 = max(sqrt(sum((p_correct4 - newp_approx4).^2)/80))

diary off








