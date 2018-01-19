
segIm_1 = skySegmentation('images/detectSky1.bmp');
%segIm_2 = skySegmentation('images/detectSky2.bmp');
segIm_3 = skySegmentation('images/detectSky3.bmp');
% 
figure(4)
imagesc(segIm_1)
%  figure(5)
%  imagesc(segIm_2)
figure(6)
imagesc(segIm_3)

% stereoIm_1 = stereoMatching('images/left1.png','images/right1.png');
% figure(7)
% imagesc(stereoIm_1)
% colormap(gray);
% imwrite(stereoIm_1, 'stereo1.png');
% imagesc(stereoIm_1)
% stereoIm_2 = stereoMatching('images/left2.png','images/right2.png');
% figure(8)
% imagesc(stereoIm_2)
% stereoIm_3 = stereoMatching('images/left3.bmp','images/right3.bmp');
% figure(9)
% imagesc(stereoIm_3)