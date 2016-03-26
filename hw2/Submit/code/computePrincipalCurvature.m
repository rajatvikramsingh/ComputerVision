function [ PrincipalCurvature ] = computePrincipalCurvature( DoGPyramid )
%COMPUTEPRINCIPALCURVATURE Summary of this function goes here
%   Detailed explanation goes here
PrincipalCurvature = zeros(size(DoGPyramid));
for j=1:size(DoGPyramid, 3)
    oneLevel = DoGPyramid(:,:,j);
    [dx, dy] = gradient(oneLevel);
    [dxx, dyx] = gradient(dx);
    [dxy, dyy] = gradient(dy);
    R = ((dxx + dyy).^2)./(dxx.*dyy - dyx.*dxy);
    PrincipalCurvature(:,:,j) = R;
end
end

