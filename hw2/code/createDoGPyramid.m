function [ DoGPyramid, DoGLevels ] = createDoGPyramid(GaussianPyramid, levels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sizeDoGLevels = size(levels, 2) - 1;
DoGPyramid = zeros(size(GaussianPyramid, 1), size(GaussianPyramid, 2), sizeDoGLevels-1);
for i=2:sizeDoGLevels
    DoGPyramid(:,:,i) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i - 1);
end
DoGLevels = levels(2:size(levels, 2));
