function TestRecognition()
test1realLabel = [1;6;14;7;2;8;10;9;11;13;
                  14;1;2;6;8;9;13;11;7;10;
                  2;8;1;14;13;6;7;10;11;9;
                  14;8;7;10;2;6;13;1;9;11;
                  7;8;14;1;13;6;10;11;2;9;
                  8;7;13;10;14;1;2;11;6;9;
                  14;6;7;8;10;13;1;9;2;11];
test2realLabel = [3;4;5;12;15;16;1;8;14;6;
                  12;15;14;6;16;5;8;1;4;3;
                  14;6;8;15;12;5;16;1;4;3;
                  6;12;14;15;4;5;16;1;8;3;
                  15;12;6;5;16;1;8;14;4;3;
                  14;6;8;1;16;12;5;4;15;3;
                  6;14;8;12;16;1;15;4;5;3;
                  12;6;4;8;5;1;14;3;15;16];
th = 210;%threshold
[NormFeaMatAll,LableNorFeaMatAll,MeanofFeatures,StanDevia] = OCR_Extract_Features();
test1 = imread('test1.bmp');
test2 = imread('test2.bmp');
im1 = uint8(test1 < th);
im2 = uint8(test2 < th);
x1 = bwlabel(im1);
x2 = bwlabel(im2);
[Features1,locations1] = BoundingBox(x1,im1);
[Features2,locations2] = BoundingBox(x2,im2);
NormFeatures1 = [];
[m,n] = size(Features1);
for j=1:m;
    for k=1:n;
        NormFeatures1(j,k) = (Features1(j,k) - MeanofFeatures(1,k)) / StanDevia(1,k);
    end
end
FeatureMatrix1 = [];
FeatureMatrix1 = NormFeatures1;%FeatureMatrix is the normalized matrix
D1 = dist2(FeatureMatrix1, NormFeaMatAll);
figure
imagesc(D1) 
title('Distance Matrix for test1')
%rating for test1
[D1_distance, D1_index] = sort(D1, 2);
NeigIndex1 = D1_index(:,1:7);
LabelMatrix1 = [];
[m,n] = size(NeigIndex1);
for p = 1:m;
    for q = 1:n;
        z = NeigIndex1(p,q);
        LabelMatrix1(p,q) = LableNorFeaMatAll(z,7);
    end
end
LabelMatrix1 = [LabelMatrix1,LabelMatrix1(:,1:3)];
LabelMatrix1;
[M,F,C]=mode(LabelMatrix1,2);

t = 0;
for s = 1:length(test1realLabel);
    if M(s,1) == test1realLabel(s,1)
        t = t + 1;
    end
end
Test1Rate = t / length(test1realLabel)

%test2
NormFeatures2 = [];
[p,q] = size(Features2);
for l=1:p;
    for s=1:q;
        NormFeatures2(l,s) = (Features2(l,s) - MeanofFeatures(s)) / StanDevia(s);
    end
end
FeatureMatrix2 = [];
FeatureMatrix2 = NormFeatures2;%FeatureMatrix is the normalized matrix
D2 = dist2(FeatureMatrix2, NormFeaMatAll);
figure
imagesc(D2) 
title('Distance Matrix for test2')
%rating for test2
[D2_distance, D2_index] = sort(D2, 2);
NeigIndex2 = D2_index(:,1:7);
LabelMatrix2 = [];
[m,n] = size(NeigIndex2);
for p = 1:m;
    for q = 1:n;
        z = NeigIndex2(p,q);
        LabelMatrix2(p,q) = LableNorFeaMatAll(z,7);
    end
end
LabelMatrix2 = [LabelMatrix2,LabelMatrix2(:,1:3)];
LabelMatrix2;
[M2,F,C]=mode(LabelMatrix2,2);

t = 0;
for s = 1:length(test2realLabel);
    if M2(s,1) == test2realLabel(s,1)
        t = t + 1;
    end
end
Test2Rate = t / length(test2realLabel)

