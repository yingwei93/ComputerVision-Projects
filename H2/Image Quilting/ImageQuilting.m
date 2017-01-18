function t2 = ImageQuilting(path, WindowSize)

texture = imread(path);
figure;
imshow(texture);

figure;

outsize = [213, 213];                     
overlapsize =2;

if WindowSize == 5
    outsize = [205, 205];
    overlapsize = 2;
end
if WindowSize == 9
    outsize = [211,211];
    overlapsize = 3;
end
if WindowSize == 11
    outsize = [213, 213];
    overlapsize = 4;
end

isdebug = 0;

t2 = synthesize(texture, outsize, WindowSize, overlapsize, isdebug);

imshow(uint8(t2));

%%%%%%%%%%%%%%
figure;
imshow(uint8(t2(1:200, 1:200, :)))    

end

