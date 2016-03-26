function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%IMAGESTITCHING NOCLIP Summary of this function goes here
%   Detailed explanation goes here
im_width = size(img2, 1);
im_height = size(img2, 2);
points_of_interest = [[[1; 1], [im_height; 1], [1; im_width], [im_height; im_width]]; ones(1, 4)];
newPoints = H2to1*points_of_interest;
newPoints(1,:) = round(newPoints(1,:)./newPoints(3,:));
newPoints(2,:) = round(newPoints(2,:)./newPoints(3,:));

if (min(newPoints(2, :))>0)
    tr_y=0;
else
    tr_y = min(newPoints(2,:));
end

if (min(newPoints(1, :))>0)
    tr_x=0;
else
    tr_x = min(newPoints(1,:));
end

pano_width = 1280;
out_height = max(newPoints(2, :)) - tr_y;
out_width = max(newPoints(1, :)) - tr_x;
out_height = round((pano_width * out_height)/out_width);
out_width = pano_width;
out_size = [out_height, out_width];
aspect_ratio = out_height/max(newPoints(2, :) - tr_y);

M = [eye(3, 2),[tr_x; -tr_y; 1/aspect_ratio]];
img1_warped = warpH(img1, M, out_size);
img2_warped = warpH(img2, M*H2to1, out_size);
panoImg = bsxfun(@max, img1_warped, img2_warped);

end

