%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stereoMatching.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function is used to match a 'left eye' and 'right eye' image and 
% create the disparity map that can be used to determine the relative 
% proximity of each pixel relative to the camera.
%
% Arguments:
% leftImg - image corresponding to the 'left eye'
% rightImg - image corresponding to the 'right eye'
%
% Outputs:
% output - A dipsarity map.  Treat as an image, but must have a gray 
% "colormap" applied to the output to get the proper result.  hw1.m takes
% care of this when setting up the image for presentation and storage.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function output = stereoMatching(leftImg, rightImg)

    % Set a few variables that are critical
    DISPARITY_RANGE = 50;
    WIN_SIZE = 5;
    EXTEND = (WIN_SIZE-1)/2;
    
    % Convert the images to grayscale image matrix
    lleft = double(rgb2gray(imread(leftImg)));
    lright = double(rgb2gray(imread(rightImg)));
    
    % Get the important dimensions
    [Ny Nx depth] = size(lleft);
   
    % Initialize a disparity that has the same dimensions as left and right
    DISPARITY = zeros(Ny, Nx);
    
    % Iterate through each pixel within the image
    for y=1:Ny
        for x=1:Nx
            
            % Initialize the two variables to track
            bestDisparity = 0;
            bestNCC = 0;        % Lowest NCC score
            
            for disp = 1:DISPARITY_RANGE
                
                % Define the limits of the filter that we will drag across
                % the image
                top = y-EXTEND;
                bottom = y+EXTEND;
                left_leftside = x-EXTEND;
                left_rightside = x+EXTEND;
                right_leftside = x-disp-EXTEND;
                right_rightside = x-disp+EXTEND;
                
                % This flag will signal whether or not we will perform an
                % NCC.  It is set if the filter's limits extend beyond the
                % limits of the image itself.
                skipFlag = 0;
                
                % These are the if statements that checks to see if the
                % filter's bounds lie within the image's bounds
                if(top < 1)
                    skipFlag = 1;         
                elseif(bottom > Ny)
                    skipFlag = 1;             
                elseif(left_leftside < 1)
                    skipFlag = 1;                
                elseif(left_rightside > Nx)
                    skipFlag = 1;                
                elseif(right_leftside < 1)
                    skipFlag = 1;                
                elseif(right_rightside > Nx)
                    skipFlag = 1;
                end
                
                % If we aren't prompted to skip this round of NCC, proceed.
                if(skipFlag == 0)
                    % Get the patches that correspond to the left and right
                    % images
                    Patch1 = lleft(top:bottom,x-EXTEND:x+EXTEND);
                    Patch2 = lright(top:bottom, x-disp-EXTEND:x-disp+EXTEND);

                    % Calculate the NCC for this iteration
                    currNCC = NCC(Patch1, Patch2);
                   
                    % If we have found a better NCC score
                    if(currNCC > bestNCC)
                        bestNCC = currNCC;      % Replace the old scores
                        bestDisparity = disp;
                    end
                end
            end
            
            % Get the best disparity
            DISPARITY(y,x) = bestDisparity; 
        end
    end
    
    % Store the output
    output = DISPARITY;
end