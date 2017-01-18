function [P] = getP(pointcube,pointcamera)
P1 = [pointcube',0,0,0,0,-pointcamera(1)*pointcube'];
P2 = [0,0,0,0,pointcube',-pointcamera(2)*pointcube'];
P = [P1;P2];