
function [x,y,score] = detect(I, template, ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%

if nargin < 3
    ndet = 1;
end

ohist = hog(I);
%corr = zeros(size(ohist, 1) + size(template, 1) - 1, size(ohist, 2) + size(template, 2) - 1, size(ohist, 3));
corr = zeros(size(ohist, 1), size(ohist, 2));
rect = [floor((size(template, 2))/2), floor((size(template, 1))/2), size(ohist, 2) - 1, size(ohist, 1) - 1];

for i=1:size(ohist, 3)
    corr = imcrop(normxcorr2(template(:,:,i), ohist(:,:,i)), rect) + corr;
end

colormap jet;
imagesc(corr);
[Y, I] = sort(corr(:), 'descend');
[y, x] = ind2sub(size(corr), I(1));
x = (x*8) - 4;
y = (y*8) - 4;
score = Y(1);
