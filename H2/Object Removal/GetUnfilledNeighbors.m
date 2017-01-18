function pixelist=GetUnfilledNeighbors(image,WindowSize)
image1=image;
image1(image<1) = 0 ;
image1(image>=1) = 255;
image2=(imdilate(image,strel('square',3)))-image1;

[row,col]=find(image2>0);
pixel=horzcat(row,col);
padI = padarray(image,[floor(WindowSize/2) floor(WindowSize/2)] );
temp=[];
for i=1 : size(pixel,1) ;
    template=double(padI( pixel(i,1) : (pixel(i,1)+WindowSize-1) , pixel(i,2) : (pixel(i,2)+WindowSize-1)) );
    n = nnz(template);
    temp=[temp;n,pixel(i,:)];
end
pixelist=sortrows(temp,-1);
pixelist=pixelist(: , 2:3);