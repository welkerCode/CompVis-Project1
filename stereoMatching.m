function output = stereoMatching(leftImg, rightImg)

    % Set a few variables that are critical
    DISPARITY_RANGE = 50;
    WIN_SIZE = 5;
    EXTEND = (WIN_SIZE-1)/2;
    
    % Convert the images to image matrix
    leftImgMatrix = imread(leftImg);
    rightImgMatrix = imread(rightImg);
    
    % Convert the images to grayscale
    lleft = rgb2gray(leftImgMatrix);
    lright = rgb2gray(rightImgMatrix);
    
    % Get the important dimensions
    dim = size(lleft);
    Nx = dim(2);
    Ny = dim(1);
   
    % Initialize a disparity that has the same dimensions as left and right
    DISPARITY = zeros(dim);
    
    for y=1:1:Ny
        for x=1:1:Nx
            
            % Initialize the two variables to track
            bestDisparity = 0;
            bestNCC = 0;        % Lowest NCC score
            
            for disp = 1:1:DISPARITY_RANGE
            
                top = y-EXTEND;
                bottom = y + EXTEND;
                left_leftside = x-EXTEND;
                left_rightside = x+EXTEND;
                right_leftside = x-disp-EXTEND;
                right_rightside = x-disp+EXTEND;
                
                skipFlag = 0;
                
                if(top < 1)
                    skipFlag = 1;
                end
                
                if(bottom > Ny)
                    skipFlag = 1;
                end
               
                if(left_leftside < 1)
                    skipFlag = 1;
                end
                
                if(left_rightside > Nx)
                    skipFlag = 1;
                end
                
                if(right_leftside < 1)
                    skipFlag = 1;
                end
                
                if(right_rightside > Nx)
                    skipFlag = 1;
                end
                
                if(skipFlag == 0)
                    % How should I move these patches?
                    Patch1 = lleft(y - EXTEND:y+EXTEND,x - EXTEND:x + EXTEND);
                    Patch2 = lright(y-EXTEND:y+EXTEND, x-disp-EXTEND:x-disp+EXTEND);

                    % Calculate the NCC for this iteration
                    currNCC = NCC(Patch1, Patch2);
                   
                    % If we have found a better NCC score
                    if(currNCC >= bestNCC)
                        bestNCC = currNCC;      % Replace the old scores
                        bestDisparity = disp;
                    end
                end
            end
            
            DISPARITY(y,x) = bestDisparity; % Get the best disparity
        end
    end
    
    output = DISPARITY;
end

% Take random pixel (x,y), same horizontal line, got to the same x location, but search in a small range