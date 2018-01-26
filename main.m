%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hw1.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This file is simply run without any arguments.  It is responsible for
% running every example for each of the three different image processing
% algorithms implemented in this project.  It first writes the resulting
% images to figures, and saves them to files within the resultingImages 
% folder.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following command was learned from 
% https://www.mathworks.com/matlabcentral/answers/31113-call-functions-from-subpath
addpath(genpath('/Functions'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Edge Extraction   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Image 1
edgeIm_1 = extractEdges('Inputs/lineDetect1.bmp');
figure(1);
imagesc(edgeIm_1)
print('Outputs/edge1','-dbmp');

% Image 2
edgeIm_2 = extractEdges('Inputs/lineDetect2.bmp');
figure(2);
imagesc(edgeIm_2)
print('Outputs/edge2','-dbmp');

% Image 3
edgeIm_3 = extractEdges('Inputs/lineDetect3.bmp');
figure(3);
imagesc(edgeIm_3)
print('Outputs/edge3','-dbmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Sky Segmentation  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Image 1
segIm_1 = skySegmentation('Inputs/detectSky1.bmp', 1);% 
figure(4)
imagesc(segIm_1)
print('Outputs/sky1','-dbmp');

% Image 2
segIm_2 = skySegmentation('Inputs/detectSky2.bmp', 2);
figure(5)
imagesc(segIm_2)
print('Outputs/sky2','-dbmp');

% Image 3
segIm_3 = skySegmentation('Inputs/detectSky3.bmp', 3);
figure(6)
imagesc(segIm_3)
print('Outputs/sky3','-dbmp');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Stereo Matching   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Image 1
stereoIm_1 = stereoMatching('Inputs/left1.png','Inputs/right1.png');
figure(7);
imagesc(stereoIm_1);
colormap(gray);
print('Outputs/stereo1','-dpng');

% Image 2
stereoIm_2 = stereoMatching('Inputs/left2.png','Inputs/right2.png');
figure(8);
imagesc(stereoIm_2)
colormap(gray);
print('Outputs/stereo2','-dpng');

% Image 3
stereoIm_3 = stereoMatching('Inputs/left3.bmp','Inputs/right3.bmp');
figure(9)
imagesc(stereoIm_3)
colormap(gray);
print('Outputs/stereo3','-dbmp');