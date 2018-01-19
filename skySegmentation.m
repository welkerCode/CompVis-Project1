function output = skySegmentation(image)

    % Convert the image to an image matrix
    imageMatrix = imread(image);
    
%     % Set our thresholds
%     R_MIN = 0;
%     R_MAX = 100;
%     G_MIN = 1;
%     G_MAX = 150;
%     B_MIN = 100;
%     B_MAX = 255;
    
    % This is our thresholds for detectSky1
    R_MIN = 50;
    R_MAX = 185;
    G_MIN = 115;
    G_MAX = 230;
    B_MIN = 215;
    B_MAX = 255;
    
    % This is our threshold for detectSky2
%     R_MIN = 165;
%     R_MAX = 250;
%     G_MIN = 230;
%     G_MAX = 255;
%     B_MIN = 245;
%     B_MAX = 255;

    % This is our thresholds for detectSky3
    R_MIN = 50;
    R_MAX = 185;
    G_MIN = 100;
    G_MAX = 255;
    B_MIN = 180;
    B_MAX = 255;
    
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