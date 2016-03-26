function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)
%DOGDETECTOR Summary of this function goes here
%   Detailed explanation goes here
GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
points=[locsDoG(:,2) locsDoG(:,1)];
imshow(im);
hold on;
plot(points(:,2),points(:,1), 'r.','MarkerSize',20);
hold off;
end
