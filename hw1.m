
segIm_1 = skySegmentation('images/detectSky1.bmp');
segIm_2 = skySegmentation('images/detectSky2.bmp');
segIm_3 = skySegmentation('images/detectSky3.bmp');

figure(4)
imagesc(segIm_1)
figure(5)
imagesc(segIm_2)
figure(6)
imagesc(segIm_3)

stereoIm_1 = stereoMatching('images/left1.png','images/right1.png');
stereoIm_2 = stereoMatching('images/left2.png','images/right2.png');
stereoIm_3 = stereoMatching('images/left3.png','images/right3.png');

figure(7)
imagesc(stereoIm_1)
figure(8)
imagesc(stereoIm_2)
figure(9)
imagesc(stereoIm_3)