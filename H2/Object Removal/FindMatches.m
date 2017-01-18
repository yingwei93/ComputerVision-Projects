function [GoodMatch,error]=FindMatches(template,image)
WindowSize=size(template,1);
[row,col] = size(image);
padI = padarray(image,[floor(WindowSize/2) floor(WindowSize/2)]);
Sigma=WindowSize/6.4;
ErrThreshold = 0.1;
SSD=zeros(row,col);
ValidMask = template;
ValidMask( ValidMask>0 )=1;
GaussMask =  fspecial('gaussian', WindowSize, Sigma) ;
totweight=  sum(sum(times(ValidMask , GaussMask)));

for i=1:row;
    for j=1:col;
        dist=(template)-double(padI(i:(i+WindowSize-1),j:(j+WindowSize-1)));
        dist=dist.*dist;
        tempm=dist.*ValidMask;
        tempm=tempm.*GaussMask;
        SSD(i,j)=((sum(sum(tempm)))/totweight);        
    end
end

GoodMatch=[];
error=[];
temps=SSD;
temps(temps==0)=1000;
minSSD = min(min(temps));
for i=1 : row ;
    for j=1 : col ;
        if (SSD(i,j) <= minSSD*(1+ErrThreshold))
            error=[error;SSD(i,j)-minSSD*(1+ErrThreshold)];
            GoodMatch=[GoodMatch;image(i,j)];
        end
    end
end