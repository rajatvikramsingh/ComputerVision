function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
N = 16;
g = gausswin(N, 4);
g = g * g';
%surf(g);


x1 = ceil(x1);
y1 = ceil(y1);
x2 = 0;
y2 = 0;
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
if ((x1 - N/2 > 1 && x1 + N/2 < size(im1, 1)) && (y1 - N/2 > 1 && y1 + N/2 < size(im1, 2)))
    im1win = im1(y1 - N/2: y1 + N/2 - 1, x1 - N/2: x1 + N/2 - 1);
    im1winFin = double(im1win).*g;
    %imshow(im1winFin);
else 
    im1winFin = zeros(N);
end
temp = F*[x1;y1;1];
normTemp = temp/(sqrt(temp(1)^2 + temp(2)^2));

minDistance = Inf;
for y2Fin = N-2 + 1: size(im2, 1) - N/2 - 1
    x2Fin = ceil(-((normTemp(2)*y2Fin + normTemp(3))/normTemp(1)));
    if ((x2Fin - N/2 < 1 || x2Fin + N/2 > size(im1, 2)) || (y2Fin - N/2 < 1 || y2Fin + N/2 > size(im1, 1)))
        continue;
    end
    im2win = im2(y2Fin - N/2: y2Fin + N/2 - 1, x2Fin - N/2: x2Fin + N/2 - 1);
    im2winFin = double(im2win).*g;
    %imshow(im2winFin);
    dist = sqrt(sum(sum((im1winFin - im2winFin).^2)));
    pointDis = sqrt((x1-x2)^2 + (y1-y2)^2);
    finDist = 0.75 * dist + 0.25 * pointDis;
    if (finDist < minDistance)
        minDistance = finDist;
        x2 = x2Fin;
        y2 = y2Fin;
    end
end
%save('q2_6.mat', 'F', 'pts1', 'pts2');
end