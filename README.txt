CS 6320 Computer Vision
Homework 1
Taylor Welker - u0778812
January 25, 2018

#################
TO RUN
#################

Simply run the main.m file.  It takes care of everything.  Outputs will be stored as image files in the Outputs folder, as well as printed in 'Figures'.

Total Time to execute: ~ 10 minutes (the last stereo image takes a while)

#################
FUNCTION FILES:
#################

### Extracting Edges ###
extractEdges.m - the function that extracts edges from an input image.  Called by the main.m file.
getRandomPixel.m - a helper function for extractEdges.m that obtains random pixels from EDGE_SET.
getLineEst.m - a helper function for extractEdges.m that estimates the how well the line fits a particular pixel.

### Sky Segmentation ###
skySegmentation.m - the function that determines the pixels that correspond with the sky of the input image.  Called by the main.m file.

### Stereo Matching ###
stereoMatching.m - the function that generates a disparity image given a 'left-eye' and 'right-eye' image.  Called by the main.m file.
NCC.m - a helper function for stereoMatching.m that calculates the NCC value between two 'patches' (one from left and one from right)
 
#################
INPUT FILES:
#################

### Extracting Edges ###
lineDetect1.bmp
lineDetect2.bmp
lineDetect3.bmp

### Sky Segmentation ###
detectSky1.bmp
detectSky2.bmp
detectSky3.bmp

### Stereo Matching ###
left1.png
right1.png
left2.png
right2.png
left3.bmp
right3.bmp

#################
OUTPUT FILES:
#################

### Extracting Edges ###
edge1.bmp
edge2.bmp
edge3.bmp

### Sky Segmentation ###
sky1.bmp
sky2.bmp
sky3.bmp

### Stereo Matching ###
stereo1.png
stereo2.png
stereo3.bmp


#####################
SITES FOR RESEARCH
#####################
How to access functions in another folder outside of the MATLAB root: 
	https://www.mathworks.com/matlabcentral/answers/31113-call-functions-from-subpath

How RGB colors work in MATLAB: 
	https://www.mathworks.com/company/newsletters/articles/how-matlab-represents-pixel-colors.html