function entire_image = GrowImage(original_image,WindowSize)
entire_image = zeros(200,200);
im = imread(original_image);
im(im == 0) = 1;
[eRow,eCol]=size(entire_image);
[oRow,oCol]=size(im);
xGap=floor(eRow/2)-floor(oRow/2);
yGap=floor(eCol/2)-floor(oCol/2);
tempm = entire_image;
for p=1:oRow
    for q=1:oCol
        tempm(xGap+p,yGap+q)=im(p,q);
    end
end
entire_image = uint8(tempm);
MaxErrThreshold = 0.3;
figure
count = 40000 - nnz(entire_image);
while (min(min(entire_image)) == 0);
    count = 40000 - nnz(entire_image)
    progress = 0;
    pixel_list = GetUnfilledNeighbors(entire_image,WindowSize);
    for i = 1:size(pixel_list,1);        
        template = GetNeighborhoodWindow(pixel_list(i,:),entire_image,WindowSize);
        [GoodMatch, error]= FindMatches(template, im);      
        a = 1;
        b = size(GoodMatch,1);
        ran = floor((b-a).*rand(1,1) + a);
        if (error(ran) < MaxErrThreshold)
            entire_image(pixel_list(i,1),pixel_list(i,2)) = GoodMatch(ran);
            progress = 1;               
        end        
    end
    if (progress == 0)
        MaxErrThreshold = MaxErrThreshold * 1.1;
    end
    imshow(entire_image);
end
figure
imshow(entire_image);