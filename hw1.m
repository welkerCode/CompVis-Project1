
segIm_1 = skySegmentation('images/detectSky1.bmp');
segIm_2 = skySegmentation('images/detectSky2.bmp');
segIm_3 = skySegmentation('images/detectSky3.bmp');

figure(1)
imagesc(segIm_1)
figure(2)
imagesc(segIm_2)
figure(3)
imagesc(segIm_3)