function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%   corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
%% SSD code below: 
ssd = Inf;
[X Y] = meshgrid(-30:30, -30:30);
for k=-30:30
    for l=-30:30
        newssd = (sum(sum((red - circshift(blue, [k, l])).^2)));
        if (newssd < ssd)
            ssd = newssd;
            shiftKBS = k; %shiftKBS - ShiftK Blue SSD
            shiftLBS = l; %shiftLBS - ShiftL Blue SSD
        end
    end
end
ssd = Inf;
for k=-30:30
    for l=-30:30
        newssd = (sum(sum((red - circshift(green, [k, l])).^2)));
        if (newssd < ssd)
            ssd = newssd;
            shiftKGS = k; %shiftKGS - ShiftK Green SSD
            shiftLGS = l; %shiftLGS - ShiftL Green SSD
        end
    end
end

bluetemp = circshift(blue, [shiftKBS, shiftLBS]);
greentemp = circshift(green, [shiftKGS, shiftLGS]);
rgbResult = cat(3, red, greentemp, bluetemp);
%imshow(rgbResult);

%% NCC code below:
% nccVal = -Inf;
% for k=-30:30
%     for l=-30:30
%         bluetemp = circshift(blue, [k, l]);
%         score = ncc(red, bluetemp);
%         if (score > nccVal)
%             nccVal = score;
%             shiftKBN = k;
%             shiftLBN = l;
%         end
%     end
% end
% 
% nccVal = -Inf;
% for k=-30:30
%     for l=-30:30
%         greentemp = circshift(green, [k, l]);
%         score = ncc(red, greentemp);
%         if (score > nccVal)
%             nccVal = score;
%             shiftKGN = k;
%             shiftLGN = l;
%         end
%     end
% end
% 
% bluetemp = circshift(blue, [shiftKBN, shiftLBN]);
% greentemp = circshift(green, [shiftKGN, shiftLGN]);
% imout = cat(3, red, greentemp, bluetemp);
% imshow(imout);
end