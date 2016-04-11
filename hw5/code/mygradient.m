function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

[dx, dy] = gradient(I);
mag = sqrt((dx./dx) + (dy.*dy));
ori = atan2d(dx, dy);
