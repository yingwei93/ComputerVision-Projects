function template = GetNeighborhoodWindow(pixel,image,windowSize)
template = zeros(windowSize,windowSize);
padI = padarray(image,[floor(windowSize/2) floor(windowSize/2)]);
template = double(padI(pixel(1,1):(pixel(1,1) + windowSize - 1) , pixel(1,2):(pixel(1,2) + windowSize - 1)));
