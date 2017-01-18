function [Features,locations] = BoundingBox(x,im2)
Nc=max(max(x));
%figure;
%imagesc(x);
hold on;
Features = [];
locations = [];
for i=1:Nc; 
[r,c]=find(x==i);
maxr=max(r);
minr=min(r);
maxc=max(c);
minc=min(c);
a = maxr - minr;
b = maxc - minc;
if (a*b > 150 && a >10 && b >10 && a < 150 && b < 150)
    %rectangle('Position',[minc,minr,maxc-minc+1,maxr-minr+1], 'EdgeColor','w');
    cim = im2(minr:maxr,minc:maxc);
    locations = [locations;(minr+maxr)/2,(minc+maxc)/2];%nearly center point
    [centroid, theta, roundness, inmo] = moments(cim, 1);
    Features=[Features; theta, roundness, inmo];
end
end
hold off