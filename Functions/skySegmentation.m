%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skySegmentation.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function is used to identify pixels that correspond with the 'sky'
% in a select few images.  The thresholds used to determine sky color
% values have been fine-tuned to each image, and therefore cannot be
% expected to perform equally as well on other images unless modified
% accordingly.
%
% Arguments:
% image - the image to be processed
%
% Outputs:
% output - the output image.  White pixels correspond with sky pixels,
% while black are non-sky pixels.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = skySegmentation(image, imageFilterSel)

    % Convert the image to an image matrix
    imageMatrix = imread(image);

    % These if statement will select our color thresholds
    if(imageFilterSel == 1)
        % This is our thresholds for detectSky1
        R_MIN = 50;
        R_MAX = 185;
        G_MIN = 115;
        G_MAX = 230;
        B_MIN = 215;
        B_MAX = 255;
    
    elseif(imageFilterSel == 2)
        % This is our threshold for detectSky2
        R_MIN = 165;
        R_MAX = 250;
        G_MIN = 230;
        G_MAX = 255;
        B_MIN = 245;
        B_MAX = 255;
   
    else
        % This is our thresholds for detectSky3
        R_MIN = 50;
        R_MAX = 185;
        G_MIN = 100;
        G_MAX = 255;
        B_MIN = 180;
        B_MAX = 255;
    end
    
    % Get the dimensions of the image
    image_dim = size(imageMatrix);
    image_height = image_dim(1);
    image_width = image_dim(2);
    
    % Initialize another image of the same size as the original
    SEGMENT = zeros(image_dim);
    
    % Iterate through the image
    for row=1:1:image_height
        for col=1:1:image_width
   
            % If the pixel values are right, write a (255,255,255) to that
            % pixel
            red = imageMatrix(row,col,1);
            green = imageMatrix(row,col,2);
            blue = imageMatrix(row,col,3);

            % Initialize variables to check the threshold of each color channel
            redThreshMet = 0;
            greenThreshMet = 0;
            blueThreshMet = 0;

            % Check the color channels to see if they meet their thresholds
            if((R_MIN <= red) &&(red <= R_MAX))
                redThreshMet = 1;
            end

            if((G_MIN <= green) && (green <= G_MAX))
                greenThreshMet = 1;
            end

            if((B_MIN <= blue) && (blue <= B_MAX))
                blueThreshMet = 1;
            end

            % If all the thresholds are met, then change the pixel to white
            if((redThreshMet == 1) && (greenThreshMet == 1) && (blueThreshMet == 1))
                SEGMENT(row,col,:) = [255,255,255];
            end
        end
    end
    
    % Set the output
    output = SEGMENT;

end