diary 'w.txt'
%grayscale image
im = imread('w.bmp');
imshow(im)
title('w')

%intensity histogram
h = imhist(im);
figure
plot(h)
title('Intensity Histogram')

%binary image
im2 = im;
th = 210;
im2 = uint8(im < th);
figure
imagesc(~im2)
colormap gray
title('Character w')

%Connected component image with bounding boxes
x = bwlabel(im2);
Nc=max(max(x));
figure;
imagesc(x);
title('Connected component image with bounding boxes')
hold on;
Features=[];
for i=1:Nc; 
[r,c]=find(x==i);
maxr=max(r);
minr=min(r);
maxc=max(c);
minc=min(c);
rectangle('Position',[minc,minr,maxc-minc+1,maxr-minr+1], 'EdgeColor','w');
cim = im2(minr:maxr,minc:maxc);
[centroid, theta, roundness, inmo] = moments(cim, 1);
Features=[Features; theta, roundness, inmo];
end
hold off
diary off