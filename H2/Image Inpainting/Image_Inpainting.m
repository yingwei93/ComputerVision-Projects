function entire_image = Image_Inpainting(image,WindowSize)
im = imread(image);
[iRow,iCol] = size(im);
tempimage=zeros(iRow,iCol);
entire_image=im;
MaxErrThreshold = 0.3;
count = 0;
figure

while (min(min(entire_image)) == 0) ;
    count = iRow * iCol - nnz(entire_image)
    progress=0;
    pixelist=UnfilledNeighbors(entire_image,WindowSize);
    for i=1:size(pixelist,1);        
        template=GetNeighborhoodWindow(pixelist(i,:),entire_image,WindowSize);
        im1=area(pixelist(i,:),entire_image);
        [GoodMatch,error]= FindMatches(template, im1);                 
        a = 1;
        b = size(GoodMatch,1);
        ran = floor((b-a).*rand(1,1) + a);
        if ( (error(ran) < MaxErrThreshold) )
            if(tempimage(pixelist(i,1),pixelist(i,2))<7)
                entire_image(pixelist(i,1),pixelist(i,2)) = GoodMatch(ran) ;
                progress=1;
                if(GoodMatch(ran) == 0)
                    tempimage(pixelist(i,1),pixelist(i,2))=tempimage(pixelist(i,1),pixelist(i,2))+1;
                end                                              
            else
                entire_image(pixelist(i,1),pixelist(i,2)) =sum(sum(GetNeighborhoodWindow(pixelist(i,:),entire_image,3)))/9;
            end                    
        end
        if(progress==0)
            MaxErrThreshold=MaxErrThreshold*1.1;
        end
        imshow(entire_image);
    end
end
figure
imshow(entire_image);