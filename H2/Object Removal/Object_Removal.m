image='test_im3.jpg';
im1 = imread(image);
im1 = rgb2gray(im1);
im1( im1==0 )=1;
entire_image=im1;
tempimage=zeros(size(im1,1),size(im1,2));
WindowSize=17;
MaxErrThreshold = 0.3;
number=input('Enter the number of objects to be removed:');
count=0;

while (count<= number);
    count=count+1;
    tempimg = roipoly(entire_image);
    emptypixel=1-tempimg;
    entire_image=entire_image.*uint8(emptypixel);
    figure
    while (min(min(entire_image)) == 0) ;
        pixelist=GetUnfilledNeighbors(entire_image,WindowSize);
        progress = 0;       
        for i=1:size(pixelist,1);
            template=GetNeighborhoodWindow(pixelist(i,:),entire_image,WindowSize);
            im=area(pixelist(i,:),entire_image);            
            [GoodMatch,error]= FindMatches(template, im);
            a = 1;
            b = size(GoodMatch,1);
            ran = floor((b-a).*rand(1,1) + a);
            if (error(ran) < MaxErrThreshold)
                if(tempimage(pixelist(i,1),pixelist(i,2))<7)
                    entire_image(pixelist(i,1),pixelist(i,2)) = GoodMatch(ran) ;
                    progress = 1;
                    if(GoodMatch(ran) == 0)
                        tempimage(pixelist(i,1),pixelist(i,2))=tempimage(pixelist(i,1),pixelist(i,2))+1;
                    end                   
                else
                    entire_image(pixelist(i,1),pixelist(i,2)) =sum(sum(GetNeighborhoodWindow(pixelist(i,:),entire_image,3)))/9;
                end
            end            
        end
        if ( progress == 0 )
            MaxErrThreshold = MaxErrThreshold * 1.1 ;
        end
    end
    figure
    imshow(entire_image);
end