diary augment.txt
close all, clear all
load twoD;
%1.Augmenting an Image
clip = imread('4.png', 'Background', [1,1,1]);
clip = im2double(rgb2gray(clip));
clip = imresize(clip,[198 172]);
imshow(clip);
%images2
im11 = imread('images2.png');
im11 = im2double(rgb2gray(im11));
[M1,N1] = size(im11);
clip_im11=ones(M1,N1);
for x = 0:171
    for y = 0:197
        p = H1_correct*[x;y;1];
        p = p./p(3);
        clip_im11(round(p(2)),round(p(1))) = clip(198-y, x+1);
    end
end
Hfilter = fspecial('disk',3);
clip_im11 = imfilter(clip_im11,Hfilter,'replicate');
clip_im11 = imsharpen(clip_im11);
clip_im11 = imadjust(clip_im11);
for x = 1:480
    for y = 1:640
        if (clip_im11(x,y) <0.98)
            im11(x,y) = clip_im11(x,y);
        end
    end
end
figure;
imshow(im11);
im11

%images9
im22 = imread('images9.png');
im22 = im2double(rgb2gray(im22));
[M2,N2] = size(im22);
clip_im22=ones(M2,N2);
for x = 0:171
    for y = 0:197
        p2 = H2_correct*[x;y;1];
        p2 = p2./p2(3);
        clip_im22(round(p2(2)),round(p2(1))) = clip(198-y, x+1);
    end
end
clip_im22 = imfilter(clip_im22,Hfilter,'replicate');
clip_im22 = imsharpen(clip_im22);
clip_im22 = imadjust(clip_im22);
for x = 1:480
    for y = 1:640
        if (clip_im22(x,y) <0.98)
            im22(x,y) = clip_im22(x,y);
        end
    end
end
figure;
imshow(im22);
im22
%images12
im33 = imread('images12.png');
im33 = im2double(rgb2gray(im33));
[M3,N3] = size(im33);
clip_im33=ones(M3,N3);
for x = 0:171
    for y = 0:197
        p3 = H3_correct*[x;y;1];
        p3 = p3./p3(3);
        clip_im33(round(p3(2)),round(p3(1))) = clip(198-y, x+1);
    end
end
clip_im33 = imfilter(clip_im33,Hfilter,'replicate');
clip_im33 = imsharpen(clip_im33);
clip_im33 = imadjust(clip_im33);
for x = 1:480
    for y = 1:640
        if (clip_im33(x,y) <0.98)
            im33(x,y) = clip_im33(x,y);
        end
    end
end
figure;
imshow(im33);
im33
%images20
im44 = imread('images20.png');
im44 = im2double(rgb2gray(im44));
[M4,N4] = size(im44);
clip_im44=ones(M4,N4);
for x = 0:171
    for y = 0:197
        p3 = H4_correct*[x;y;1];
        p3 = p3./p3(3);
        clip_im44(round(p3(2)),round(p3(1))) = clip(198-y, x+1);
    end
end
clip_im44 = imfilter(clip_im44,Hfilter,'replicate');
clip_im44 = imsharpen(clip_im44);
clip_im44 = imadjust(clip_im44);
for x = 1:480
    for y = 1:640
        if (clip_im44(x,y) <0.98)
            im44(x,y) = clip_im44(x,y);
        end
    end
end
figure;
imshow(im44);
im44
%2.Augmenting an Object
cube_down = [0,0,0,1;
               90,0,0,1;
               90,90,0,1;
               0,90,0,1];
cube_up = [0,0,90,1;
            90,0,90,1;
            90,90,90,1;
            0,90,90,1];
%images2       
im111 = imread('images2.png');
cube_downproj = zeros(4,3);
cube_upproj = zeros(4,3);
M11 = newA * [cnewR1 cnewt1];
for i = 1:4
    cube_downproj(i,:) = M11 * cube_down(i,:)';
    cube_downproj(i,:) = cube_downproj(i,:)./cube_downproj(i,3);
    cube_upproj(i,:) = M11 * cube_up(i,:)';
    cube_upproj(i,:) = cube_upproj(i,:)./cube_upproj(i,3);
end
figure()
imshow(im111),hold on
plot(cube_downproj(:,1),cube_downproj(:,2),'y','LineWidth',3)
plot(cube_downproj([1 4],1),cube_downproj([1 4],2),'y','LineWidth',3)
plot(cube_upproj(:,1),cube_upproj(:,2),'y','LineWidth',3)
plot(cube_upproj([1 4],1),cube_upproj([1 4],2),'y','LineWidth',3)

for i = 1:4
    plot([cube_upproj(i,1) cube_downproj(i,1)],[cube_upproj(i,2) cube_downproj(i,2)],'y','LineWidth',3)
end
im111
%images9       
im222 = imread('images9.png');
cube_downproj = zeros(4,3);
cube_upproj = zeros(4,3);
M22 = newA * [cnewR2 cnewt2];
for i = 1:4
    cube_downproj(i,:) = M22 * cube_down(i,:)';
    cube_downproj(i,:) = cube_downproj(i,:)./cube_downproj(i,3);
    cube_upproj(i,:) = M22 * cube_up(i,:)';
    cube_upproj(i,:) = cube_upproj(i,:)./cube_upproj(i,3);
end
figure()
imshow(im222),hold on
plot(cube_downproj(:,1),cube_downproj(:,2),'y','LineWidth',3)
plot(cube_downproj([1 4],1),cube_downproj([1 4],2),'y','LineWidth',3)
plot(cube_upproj(:,1),cube_upproj(:,2),'y','LineWidth',3)
plot(cube_upproj([1 4],1),cube_upproj([1 4],2),'y','LineWidth',3)

for i = 1:4
    plot([cube_upproj(i,1) cube_downproj(i,1)],[cube_upproj(i,2) cube_downproj(i,2)],'y','LineWidth',3)
end
im222
%images12
im333 = imread('images12.png');
cube_downproj = zeros(4,3);
cube_upproj = zeros(4,3);
M33 = newA * [cnewR3 cnewt3];
for i = 1:4
    cube_downproj(i,:) = M33 * cube_down(i,:)';
    cube_downproj(i,:) = cube_downproj(i,:)./cube_downproj(i,3);
    cube_upproj(i,:) = M33 * cube_up(i,:)';
    cube_upproj(i,:) = cube_upproj(i,:)./cube_upproj(i,3);
end
figure()
imshow(im333),hold on
plot(cube_downproj(:,1),cube_downproj(:,2),'y','LineWidth',3)
plot(cube_downproj([1 4],1),cube_downproj([1 4],2),'y','LineWidth',3)
plot(cube_upproj(:,1),cube_upproj(:,2),'y','LineWidth',3)
plot(cube_upproj([1 4],1),cube_upproj([1 4],2),'y','LineWidth',3)

for i = 1:4
    plot([cube_upproj(i,1) cube_downproj(i,1)],[cube_upproj(i,2) cube_downproj(i,2)],'y','LineWidth',3)
end
im333
%images20
im444 = imread('images20.png');
cube_downproj = zeros(4,3);
cube_upproj = zeros(4,3);
M44 = newA * [cnewR4 cnewt4];
for i = 1:4
    cube_downproj(i,:) = M44 * cube_down(i,:)';
    cube_downproj(i,:) = cube_downproj(i,:)./cube_downproj(i,3);
    cube_upproj(i,:) = M44 * cube_up(i,:)';
    cube_upproj(i,:) = cube_upproj(i,:)./cube_upproj(i,3);
end
figure()
imshow(im444),hold on
plot(cube_downproj(:,1),cube_downproj(:,2),'y','LineWidth',3)
plot(cube_downproj([1 4],1),cube_downproj([1 4],2),'y','LineWidth',3)
plot(cube_upproj(:,1),cube_upproj(:,2),'y','LineWidth',3)
plot(cube_upproj([1 4],1),cube_upproj([1 4],2),'y','LineWidth',3)

for i = 1:4
    plot([cube_upproj(i,1) cube_downproj(i,1)],[cube_upproj(i,2) cube_downproj(i,2)],'y','LineWidth',3)
end
im444
diary off