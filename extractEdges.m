%extractEdges()

% Initialize a few variables
LINE_SET = {};
ITERS = 0;
TOTAL_NO_ITERS = 10000;
MAX_PAIR_DISTANCE = 100;
MIN_POINTLINE_DISTANCE = 1;
MIN_LINE_PIXEL_NUM = 50;

img = imread('images/lineDetect1.bmp');
iedge = edge(rgb2gray(img),'Canny',0.1);

imgsize = size(img);
height = imgsize(1);
width = imgsize(2);
%cannyEdges = edge(img, 'canny')

EDGE_SET = [];

for row = 1:1:height
    for col = 1:1:width
        if(iedge(row,col) == 1)
            EDGE_SET = concatSets(EDGE_SET, [row, col]);
        end
    end
end

% Keep the iterations going until we reach our limit
while(ITERS < TOTAL_NO_ITERS)
    
    % Increment the iteration counter
    ITERS = ITERS + 1

    % Get the first random pixel coordinates
    randPix_1 = getRandomPixel(EDGE_SET);

    % This flag is meant to tell us when a valid second point has been found
    randPix_2_found = 0;

    % Until we find that second point
    while(randPix_2_found == 0)
        
        % Get a new random point
        newRandPix = getRandomPixel(EDGE_SET); 

        % Find the distance between the two points
        xdiff = randPix_1(1) - newRandPix(1);
        ydiff = randPix_1(2) - newRandPix(2);
        pairDistance = sqrt(xdiff^2 + ydiff^2); % Pythagorean theorem

        % If the points are the same ignore it
        if(newRandPix == randPix_1) 
            randPix_2_found = 0;
            
        % Case to leave loop
        elseif(pairDistance < MAX_PAIR_DISTANCE) 
            randPix_2_found = 1;
            randPix_2 = newRandPix;
        end
    end

    % Create a line between the two points (ax + by + c = 0)
    slope = (randPix_2(2) - randPix_1(2)) / (randPix_2(1) - randPix_1(1));
    offset = (-slope * randPix_1(1)) + randPix_1(2);
    a = -slope;
    b = 1;
    c = -offset;
    
    % Get the total number of pixels left in the EDGE_SET
    total_num_pixels = size(EDGE_SET);
    total_num_pixels = total_num_pixels(1);

    % Create a set to hold the points that fit this line
    INLIER = [];
    
    % Iterate through each pixel in the set
    for pixel=1:1:total_num_pixels;
        
        % Get what the line predicts the value should be
        est = getLineEst(EDGE_SET(pixel,:),a,b,c);
        
        % If that value is within the Minimum Pointline Distance
        if(est < MIN_POINTLINE_DISTANCE)
            INLIER = concatSets(INLIER, EDGE_SET(pixel,:));
        end
    end
    
    % After iterating through the whole EDGE_SET, add the INLIER to the
    % LINE_SET if there are enough edge pixels
    INLIER_dim = size(INLIER);
    INLIER_num = INLIER_dim(1);
    if(INLIER_num >= MIN_LINE_PIXEL_NUM);
        LINE_SET = concatSets(LINE_SET, INLIER);
        
        % Also, if we add them to the line set, we must remove these same
        % pixels from the EDGE_SET
        
    end    
end

% Finally, at the end, we need to assign each line segment a random color
% and plot them

