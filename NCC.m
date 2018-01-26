%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NCC.m 
% Author: Taylor Welker
% Date: January 25, 2017
%
% This function acts as a helper function to the 'stereoMatching.m'
% function.  It is used to calculate the NCC on the two patches obtained by
% its parent function.
%
% Arguments:
% leftPatch - 5x5 matrix from the left image used in disparity calculation
% rightPatch - 5x5 matrix from the right image used in disparity calculation
%
% Outputs:
% output - The value computed using the NCC equation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = NCC(leftPatch, rightPatch)

    % Handle the numerator
    num_prod = leftPatch .* rightPatch;
    num = sum(sum(num_prod));
    
    % Handle the denominator
    leftPatchSquared = leftPatch.*leftPatch;
    rightPatchSquared = rightPatch.*rightPatch;
    leftSum = sum(sum(leftPatchSquared));
    rightSum = sum(sum(rightPatchSquared));
    den = sqrt(leftSum) * sqrt(rightSum);

    % Divide them out
    output = num / den;
end