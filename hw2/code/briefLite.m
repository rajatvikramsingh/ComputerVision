function [locs, desc] = briefLite(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sigma0=1;
k=sqrt(2);

levels = [-1 0 1 2 3 4];
th_contrast=0.03;
th_r = 12;

[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
load('testPattern.mat');
[locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY);

end

