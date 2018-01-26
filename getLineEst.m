%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getLineEst.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function is a helper function for 'extractEdges.m'.  It is used to
% obtain the expected value for a pixel's coordinates with respect to the
% line model in question.  If it is a perfect match, it should  return a 0.
% The farther away from 0 the output is, the less good of a fit the line
% is.
%
% The line modelis described by the equation:
%   ax + by + c = 0
%
% Arguments:
% pixel - Holds the x and y coordinates of the pixel, and corresponds to
%         the x, and y elements of the line model.
% a - the value 'a' in the line model (determined previously in
%     'extractEdges.m')
% b - the value 'b' in the line model (determined previously in
%     'extractEdges.m')
% c - the value 'c' in the line model (determined previously in
%     'extractEdges.m')
%
% Output:
% est - The value that pixel should returns with regards to the line model.
%       A value of 0 indicates a perfect fit.  The farther away from 0 the 
%       value ends up being, the less accurate the fit.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function est = getLineEst(pixel,a,b,c)

est = pixel(2) * a + pixel(1) * b + c;

end