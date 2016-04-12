
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

% [y, x] = ind2sub(size(corr), I(1));
% x = (x*8) - 4;
% y = (y*8) - 4;
% score = Y(1);
%
x = zeros(1, ndet);
y = zeros(1, ndet);
score = zeros(1, ndet);

j =1;
for i=1:ndet
    done = 0;
    while done~=1 && j < size(I, 1)
        [y1, x1] = ind2sub(size(corr), I(j));
        x1 = (x1*8)-4;
        y1 = (y1*8)-4;      
        if nonmaxsuppression(x, y, ones(1, size(x, 2)), x1, y1, 1) == 0
            x(i) = x1;
            y(i) = y1;
            score(i) = Y(j);
            done = 1;
        end
        j = j+1;
    end
end

