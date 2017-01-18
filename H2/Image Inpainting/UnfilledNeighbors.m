function pixelist=UnfilledNeighbors(image,WindowSize)
[row,col]=find(image==0);
pixel=horzcat(row,col);
padI = padarray(image,[floor(WindowSize/2) floor(WindowSize/2)] );
temp=[];
for i=1 : size(pixel,1) ;
    template=double(padI( pixel(i,1) : (pixel(i,1)+WindowSize-1) , pixel(i,2) : (pixel(i,2)+WindowSize-1)) );
    n = nnz(template);
    if ( n ~= 0)
        temp=[temp;n,pixel(i,:)];
    end    
end
pixelist=sortrows(temp,-1);
pixelist=pixelist(: , 2:3);