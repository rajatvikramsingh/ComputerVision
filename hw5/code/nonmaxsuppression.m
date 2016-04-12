function [ bool ] = nonmaxsuppression(x, y, fscale, x1, y1, scale)
%CHECK_BOUND Summary of this function goes here
%   Detailed explanation goes here
bool = 0;
for i=1:size(x, 2)
    if (x(i) ~= 0 && y(i) ~=0)
        if ((floor(x1 - 64/scale) >= floor(x(i) - 64/fscale(i)) && floor(x1 - 64/scale) <= floor(x(i) + 64/fscale(i)) && floor(y1 - 64/scale) >= floor(y(i) - 64/fscale(i)) && floor(y1 - 64/scale) <= floor(y(i) + 64/fscale(i))) || ...
                (floor(x1 + 64/scale) >= floor(x(i) - 64/fscale(i)) && floor(x1 + 64/scale) <= floor(x(i) + 64/fscale(i)) && floor(y1 - 64/scale) >= floor(y(i) - 64/fscale(i)) && floor(y1 - 64/scale) <= floor(y(i) + 64/fscale(i))) || ...
                (floor(x1 - 64/scale) >= floor(x(i) - 64/fscale(i)) && floor(x1 - 64/scale) <= floor(x(i) + 64/fscale(i)) && floor(y1 + 64/scale) >= floor(y(i) - 64/fscale(i)) && floor(y1 + 64/scale) <= floor(y(i) + 64/fscale(i))) || ...
                (floor(x1 + 64/scale) >= floor(x(i) - 64/fscale(i)) && floor(x1 + 64/scale) <= floor(x(i) + 64/fscale(i)) && floor(y1 + 64/scale) >= floor(y(i) - 64/fscale(i)) && floor(y1 + 64/scale) <= floor(y(i) + 64/fscale(i))) || ...
                (pdist2([x1, y1], [x(i), y(i)]) < 64/scale*sqrt(2)+64/fscale(i)*sqrt(2)))
            
            bool = 1;
            if (bool == 1)
                break;
            end
        end
    end
end
end

