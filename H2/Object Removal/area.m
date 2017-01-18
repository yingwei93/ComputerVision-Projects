function pix=area(pixel,image)
padI = padarray(image,[35 35] );
pix=double(padI( pixel(1,1) : (pixel(1,1)+70) , pixel(1,2) : (pixel(1,2)+70)) );
pix( :, ~any(pix,1) ) = [];
pix( ~any(pix,2), : ) = [];