function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
 

%Convert input Image to Lab
if(size(I, 3) == 1)
    I = repmat(I, 1, 1, 3);
end
doubleI = double(I);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);



%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===

labI(:,:,1) = L;
labI(:,:,2) = a;
labI(:,:,3) = b;
for i=1:size(filterBank, 1)
    filter = filterBank{i};
    filterResponse = reshape(imfilter(labI, filter), pixelCount, 3);
    filterResponses(:, ((i-1)*3)+1:((i-1)*3)+3) = filterResponse;
end
end
