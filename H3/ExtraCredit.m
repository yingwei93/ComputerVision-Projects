diary ExtraCredit.txt
close all, clear all
load twoD;
%cylinder
h = 4;
d = 0.1;
r = 20;
[A,Z]=meshgrid(0:2*pi/fix(2*pi/(1.2*d)):2*pi,0:h/fix(h/d):h);
LX=r.*cos(A);
LY=r.*sin(A);
shift = r .* ones(size(LX,1),size(LX,2));
LX = LX + shift;
LY = LY + shift;
Z = 20.*Z;
h1=mesh(LX,LY,Z);
axis equal
hold on
x1=-1:d:1;y1=-1:d:1;
[planeX,planeY]=meshgrid(x1,y1);
planeX(planeX.^2+planeY.^2>1)=NaN;
planeY(planeX.^2+planeY.^2>1)=NaN;
planeZ = planeX*0+h;
shift2 = r.*ones(size(planeX,1),size(planeX,2));
planeX2 = r.*planeX+shift2;
planeY2 = r*planeY+shift2;
planeZ2 = 20.*planeZ;
h2=mesh(planeX2,planeY2,planeZ2);

changdu = size(LX,1) * size(LX,2);
changdu2 = size(planeX2,1) * size(planeX2,2);
xx1 = reshape(LX,1,changdu);
yy1 = reshape(LY,1,changdu);
zz1 = reshape(Z,1,changdu);

xx2 = reshape(planeX2,1,changdu2);
yy2 = reshape(planeY2,1,changdu2);
zz2 = reshape(planeZ2,1,changdu2);

xx = cat(1,xx1',xx2');
yy = cat(1,yy1',yy2');
zz = cat(1,zz1',zz2');
 
yuanzhu= [xx';yy';zz';ones(1, changdu+changdu2)];
%images2
im1 = imread('images2.png');
P = newA * [cnewR1 cnewt1];
for i = 1:length(yuanzhu)
        mesh_proj(:,i) = P*[yuanzhu(:,i)];
        mesh_proj(1,i) = mesh_proj(1,i)/mesh_proj(3,i);
        mesh_proj(2,i) = mesh_proj(2,i)/mesh_proj(3,i);
        mesh_proj(3,i) = mesh_proj(3,i)/mesh_proj(3,i);
end
figure()
imshow(im1), hold on
plot(mesh_proj(1,:),mesh_proj(2,:),'.')
im1
%images9
im2 = imread('images9.png');
P = newA * [cnewR2 cnewt2];
for i = 1:length(yuanzhu)
        mesh_proj(:,i) = P*[yuanzhu(:,i)];
        mesh_proj(1,i) = mesh_proj(1,i)/mesh_proj(3,i);
        mesh_proj(2,i) = mesh_proj(2,i)/mesh_proj(3,i);
        mesh_proj(3,i) = mesh_proj(3,i)/mesh_proj(3,i);
end
figure()
imshow(im2), hold on
plot(mesh_proj(1,:),mesh_proj(2,:),'.')
im2
%images12
im3 = imread('images12.png');
P = newA * [cnewR3 cnewt3];
for i = 1:length(yuanzhu)
        mesh_proj(:,i) = P*[yuanzhu(:,i)];
        mesh_proj(1,i) = mesh_proj(1,i)/mesh_proj(3,i);
        mesh_proj(2,i) = mesh_proj(2,i)/mesh_proj(3,i);
        mesh_proj(3,i) = mesh_proj(3,i)/mesh_proj(3,i);
end
figure()
imshow(im3), hold on
plot(mesh_proj(1,:),mesh_proj(2,:),'.')
im3
%images20
im4 = imread('images20.png');
P = newA * [cnewR4 cnewt4];
for i = 1:length(yuanzhu)
        mesh_proj(:,i) = P*[yuanzhu(:,i)];
        mesh_proj(1,i) = mesh_proj(1,i)/mesh_proj(3,i);
        mesh_proj(2,i) = mesh_proj(2,i)/mesh_proj(3,i);
        mesh_proj(3,i) = mesh_proj(3,i)/mesh_proj(3,i);
end
figure()
imshow(im4), hold on
plot(mesh_proj(1,:),mesh_proj(2,:),'.')
im4
diary off