function [ locsDoG ] = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
%GETLOCALEXTREMA Summary of this function goes here
%   Detailed explanation goes here
% locsDoG=[];
m=1;
max1 = imregionalmax(DoGPyramid);
min1 = imregionalmin(DoGPyramid);
ext1= max1+min1;
for i=1:size(ext1, 3)
    %Check local extrema
    extLevel = ext1(:,:,i);
    extSingle = extLevel(:);
    
    pyramidLevel=DoGPyramid(:, :, i);
    pyramidLevelSingle = pyramidLevel(:);
    
    pcLevel = PrincipalCurvature(:,:,i);
    pcLevelSingle = pcLevel(:);
    
    extSingle=extSingle(:);
    for j=1:size(extSingle, 1)
        if (extSingle(j)==1)
            if (pyramidLevelSingle(j) > th_contrast && pcLevelSingle(j) < th_r)
                [k, l] = ind2sub(size(pyramidLevel), j);
                %ext1(j)=0;
                locsDoG(m, :) = [l, k, i];
                m=m+1;
            end
        end
    end
    %out(:,:,i) = reshape(ext1, size(pyramidLevel));
end
size(locsDoG)
end
