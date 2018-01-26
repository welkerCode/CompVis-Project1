%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getRandomPixel.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function is a helper function for 'extractEdges.m'.  It is used to
% obtain random pixels from the EDGE_SET in order to develop a line model.
%
% Arguments:
% EDGE_SET - The EDGE_SET from the 'extractEdges.m' function
%
% Output:
% pixel_coord - The (x,y) values of a pixel, chosen randomly from the
%               EDGE_SET.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pixel_coord = getRandomPixel(EDGE_SET)

edgeset_size = size(EDGE_SET); % Get the number of pixels within the EDGE_SET
num_pixels = edgeset_size(1);

% Find a random edge pixel
RandNum = rand;               % Find a random number between 0 and 1
index = RandNum * num_pixels; % Multiply it by the size of the array (number of edge pixels)
index = ceil(index);          % Round up to the nearest integer, this is your index
pixel_coord = EDGE_SET(index,:); % Obtain the x,y coordinates of the pixel

end
