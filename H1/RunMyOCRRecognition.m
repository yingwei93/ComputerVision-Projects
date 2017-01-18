function RecRate = RunMyOCRRecognition(filename, locations, classes)
%get the training matrix through training
I = ['a','d','f','h','k','m','n','o','p','q','r','s','u','w','x','z'];
th = 210;
[NormFeaMatAll,LableNorFeaMatAll,AvgMean,AvgStan] = OCR_Extract_Features(); 
%get the Features and realLabel of the image
image = imread(filename);
im = uint8(image < th);
x = bwlabel(im);
Nc=max(max(x));
figure;
imagesc(x);
hold on;
Features = [];
realLabel = [];
loc = [];
for i=1:Nc; 
[r,c]=find(x==i);
maxr=max(r);
minr=min(r);
maxc=max(c);
minc=min(c);
a = maxr - minr;
b = maxc - minc;
if (a*b > 150 && a > 10 && b > 10 && a < 150 && b < 150)
     rectangle('Position',[minc,minr,maxc-minc+1,maxr-minr+1], 'EdgeColor','w');
     I_x = find(locations(:,1)>minc & locations(:,1)<maxc); 
     I_y = find(locations(:,2)>minr & locations(:,2)<maxr); 
     Index = intersect(I_x, I_y);
     Realcha = I(classes(Index));
     realLabel = [realLabel;classes(Index)];
     text(maxc-2,minr,Realcha,'color', 'yellow');
     loc = [loc;maxc,maxr];
     cim = im(minr:maxr,minc:maxc);
     [centroid, theta, roundness, inmo] = moments(cim, 1);
     Features=[Features; theta, roundness, inmo];
end
end

NormFeatures = [];
[m,n] = size(Features);
for p=1:m;
    for q=1:n;
        NormFeatures(p,q) = (Features(p,q) - AvgMean(1,q)) / AvgStan(1,q);
    end
end
%calculated label
D = dist2(NormFeatures, NormFeaMatAll);
[D_distance, D_index] = sort(D, 2);
NeigIndex = D_index(:,1:5);
[m,n] = size(NeigIndex);
CalLabel = [];
for r = 1:m;
    for s = 1:n;
        z = NeigIndex(r,s);
        CalLabel(r,s) = LableNorFeaMatAll(z,7);
    end
end
CalLabel = [CalLabel,CalLabel(:,1:3)];
[M,F,C]=mode(CalLabel,2);
z = 0;
for l = 1:size(realLabel,1)
    if M(l,1) == realLabel(l,1)
        z = z + 1;
    end
end
RecRate = z / length(realLabel);
%write the calculated labels on the image
for jj = 1:length(realLabel)
    text(loc(jj,1),loc(jj,2),I(1,M(jj,1)),'color','yellow');
end
hold off
figure
imagesc(D) 
title('Distance Matrix')