function [panoImg] = imageStitching(img1, img2, H2to1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
warp_im = warpH(img2, H2to1, [size(img1, 1), size(img1, 2)+size(img2, 1)]);
padded = zeros(size(img1, 1), size(img2, 1), size(img1, 3));
img1 = [img1 padded];
panoImg = bsxfun(@max, warp_im, img1);
end
