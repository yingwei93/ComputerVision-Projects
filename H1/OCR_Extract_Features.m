function [NormFeaMatAll,LableNorFeaMatAll,AvgMean,AvgStan] = OCR_Extract_Features()   
I = ['a.bmp','d.bmp','f.bmp','h.bmp','k.bmp','m.bmp','n.bmp','o.bmp','p.bmp','q.bmp','r.bmp','s.bmp','u.bmp','w.bmp','x.bmp','z.bmp'];
th = 210;%threshold
LableFeaMatAll = [];
p = 1;
FeaMatAll = [];
for i = 1:5:(length(I)-4)
    im = imread(I(i:i+4)); 
    %im = im2double(imread(I(i:i+4)));
    im2 = uint8(im < th);
    x = bwlabel(im2);
    [Features,locations] = BoundingBox(x,im2);
    [m,n] = size(Features);
    Lable = [];
    for j=1:m;
        Lable(j,1) = p;
    end
    LableFeatures = [];
    LableFeatures = [Features,Lable];
    LableFeaMatAll = [LableFeaMatAll;LableFeatures];
    FeaMatAll = [FeaMatAll;Features];
    p = p + 1;
end   
AvgMean = mean(FeaMatAll);
AvgStan = std(FeaMatAll);
NormFeaMatAll = [];
LableNorFeaMatAll = [];
for m = 1:size(FeaMatAll,1)
    for n = 1:size(FeaMatAll,2)
        NormFeaMatAll(m,n) = (FeaMatAll(m,n) - AvgMean(1,n)) / AvgStan(1,n);
        LableNorFeaMatAll(m,n) = (FeaMatAll(m,n) - AvgMean(1,n)) / AvgStan(1,n);
    end
end
LableNorFeaMatAll = [LableNorFeaMatAll,LableFeaMatAll(:,7)];
