function [locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY)
%COMPUTEBRIEF Summary of this function goes here
%   Detailed explanation goes here
nbits = size(compareX, 1);
k=1;
patchWidth = 9;
desc=[];
[x1, y1] = ind2sub([floor(patchWidth/2), floor(patchWidth/2)], compareX);
[x2, y2] = ind2sub([floor(patchWidth/2), floor(patchWidth/2)], compareY);
for i=1:size(locsDoG, 1)
    x = locsDoG(i, 2);
    y = locsDoG(i, 1);
    if ((x + min(x1) > 0) && (x + min(x2) > 0) && (y + min(y1) > 0) && (y + min(y2) > 0) && (x + max(x1) < size(im, 1)) && (x + max(x2) < size(im, 1)) && (y + max(y1) < size(im, 2)) && (y + max(y2) < size(im, 2)))
        newdesc = zeros(1, nbits);
        for j=1:nbits
            if (im(x + x1(j), y + y1(j)) < im(x + x2(j), y + y2(j)))
                newdesc(:, j) = 1;
            end
        end
        desc = [desc; newdesc];
        locs(k, :) = locsDoG(i, :);
        k = k+1;
    end
end
end