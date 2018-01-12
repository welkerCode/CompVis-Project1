function output = NCC(leftPatch, rightPatch)

    % Handle the numerator
    num_prod = leftPatch .* rightPatch;
    num_prodColSum = sum(num_prod);
    num = sum(num_prodColSum);
    
    % Handle the denominator
    leftPatchSquared = leftPatch.*leftPatch;
    rightPatchSquared = rightPatch.*rightPatch;
    leftColSum = sum(leftPatchSquared);
    rightColSum = sum(rightPatchSquared);
    leftSum = sum(leftColSum);
    rightSum = sum(rightColSum);
    
    den = sqrt(leftSum) * sqrt(rightSum);
    
    
    % Divide them out
    output = num / den;
end