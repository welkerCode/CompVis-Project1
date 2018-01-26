%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extractEdges.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function is used to identify significant lines and edges within an
% image.  Using a canny edge detector to identify pixels of interest, this
% function takes it a step further by sifting through the pixels, and
% estimating line models that can be used to represent significant edges.
% These significant edges are then placed in a new image and labeled using
% random colors.
%
% Arguments:
% newImg - the image that we will be processing.
%
% Outputs:
% ifinal - an image with the same dimensions as the original 'newImg', but
% primarily blank with the exception of the colored edges determined by the
% function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ifinal = extractEdges(newImg)

    % Initialize a few variables
    LINE_SET = {};  % This holds our lines in arrays of pixels
    LINE_NUM = 0;   % This keeps track of the number of lines we have found
    ITERS = 0;      % This counter keeps track of the current iteration
    TOTAL_NO_ITERS = 10000;     % Max number of iterations
    MAX_PAIR_DISTANCE = 200;    % Max distance between points to model a line
    MIN_POINTLINE_DISTANCE = 15;% Limit between pixel and line model to fit
    MIN_LINE_PIXEL_NUM = 500;   % Min number of pixels to make a line

    % Setup a few measurements
    img = imread(newImg);   % Read in the image
    iedge = edge(double(rgb2gray(img)),'Canny',0.2); % Use canny edge detection
    [height width depth] = size(img);   % get the dimensions of the image
    EDGE_SET = []; % Create an array to hold results of canny edge detector
    
    % Now, we get each pixel that was detected by the canny edge detector
    % For every pixel in the image
    for row = 1:height
        for col = 1:width
            
            % If the pixel is marked by teh canny edge detector
            if(iedge(row,col) == 1)
                % Add it to the EDGE_SET
                EDGE_SET = [EDGE_SET; row, col];
            end
        end
    end

    % Get the number of pixels in the edge set (width not important)
    [EDGE_SET_SIZE EDGE_SET_WIDTH] = size(EDGE_SET);

    % Keep the iterations going until we reach our limit
    while((ITERS < TOTAL_NO_ITERS) && (EDGE_SET_SIZE > 0))

        % Increment the iteration counter
        ITERS = ITERS + 1

        % Get the first random pixel coordinates
        randPix_1 = getRandomPixel(EDGE_SET);

        % This flag is meant to tell us when a valid second point has been found
        randPix_2_found = 0;

        % These variables are meant to keep us from staying in an endless
        % loop if we happen to choose a random pixel that has no near
        % neighbors to form a line model with
        give_up = 0;        % This is the counter, initialized to 0
        GIVE_UP_ITER = 0;   % This is the flag that exits the loop if set
        GIVE_UP_MAX = 1000; % This is the max number of tries before giving up
        
        % Until we find that second point or we give up trying to find one
        while((randPix_2_found == 0) && (give_up == 0))

            % Increment the give up counter
            GIVE_UP_ITER = GIVE_UP_ITER + 1;
            
            % If we have reached our limit, give up
            if(GIVE_UP_ITER >= GIVE_UP_MAX)
                give_up = 1;
            end

            % Get a new random point
            newRandPix = getRandomPixel(EDGE_SET); 

            % Find the distance between the two points with Pythagorean thm
            ydiff = randPix_1(1) - newRandPix(1);
            xdiff = randPix_1(2) - newRandPix(2);
            pairDistance = sqrt(xdiff^2 + ydiff^2);

            % If the points are the same ignore it
            if(newRandPix == randPix_1) 
                randPix_2_found = 0;

            % Case to leave loop successfully
            elseif(pairDistance < MAX_PAIR_DISTANCE) 
                randPix_2_found = 1;    % Set the flag to leave
                randPix_2 = newRandPix; % Get the pixel value
            end
        end

        % If we didn't give up, then try to find a line
        if(give_up == 0)
            
            % Create a line between the two points (ax + by + c = 0)
            slope = (randPix_2(1) - randPix_1(1)) / (randPix_2(2) - randPix_1(2));
            offset = randPix_1(1) + (-slope * randPix_1(2));
            a = -slope;
            b = 1;
            c = -offset;

            % Create a set to hold the points that fit this line
            INLIER = [];
            
            % Create a set to hold the indices of the pixels within the
            % EDGE_SET that will be added to the line (if successful)
            INDICES_TO_REMOVE = [];

            % Iterate through each pixel in the set
            for pixel=1:EDGE_SET_SIZE

                % Get what the line predicts the value should be
                est = getLineEst(EDGE_SET(pixel,:),a,b,c);

                % If that value is within the Minimum Pointline Distance
                if(abs(est) < MIN_POINTLINE_DISTANCE)
                    
                    % Add the pixel to the INLIER set
                    INLIER = [INLIER; EDGE_SET(pixel,:)];
                    INDICES_TO_REMOVE = [INDICES_TO_REMOVE, pixel];
                end
            end

            % After iterating through the whole EDGE_SET, add the INLIER to
            % the LINE_SET if there are enough edge pixels
            [INLIER_num INLIER_depth] = size(INLIER);
            if(INLIER_num >= MIN_LINE_PIXEL_NUM);
                LINE_NUM = LINE_NUM + 1;
                LINE_SET{LINE_NUM} = INLIER;

                % Be sure to remove the pixels from the EDGE_SET
                EDGE_SET(INDICES_TO_REMOVE, :) = [];
            end 
            
            % Update the variables that keep track of EDGE_SET's size
            [EDGE_SET_SIZE EDGE_SET_WIDTH] = size(EDGE_SET);
        end
    end

    % Finally, at the end, we need to assign each line segment a random 
    % color and plot them

    % Create a new image of the same size as the original
    ifinal = double(zeros(height, width, depth));

    % Iterate through each line in LINE_SET
    for nextLine=1:LINE_NUM
        
        % Get a new random color
        % I learned about the ranges that belong in images in MATLAB from
        % here:
        % https://www.mathworks.com/company/newsletters/articles/how-matlab-represents-pixel-colors.html
        randColor = rand(1,3);

        % Get the next line
        newLine = LINE_SET{nextLine};
        [LINE_LENGTH LINE_DEPTH] = size(newLine);

        % For every pixel in that line, paint it the color obtained above.
        for curr_pixel=1:LINE_LENGTH
            pixel = newLine(curr_pixel,:);
            ifinal(pixel(1),pixel(2),:) = randColor;
        end
    end
end

%% Notes on how to deal with matrix operations 
% x[a,b]=  single dim vector
% x[a;b] = multi dim vector
% given indices x[indeces] = []
% d{1} = [1]
% d{2} = [2,4,5]