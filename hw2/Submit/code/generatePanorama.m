function im3 = generatePanorama(im1, im2)
%GENERATEPANORAMA Summary of this function goes here
%   Detailed explanation goes here
img1_in = rgb2gray(im1);
img1_in = im2double(img1_in);

img2_in = rgb2gray(im2);
img2_in = im2double(img2_in);

[locs1, desc1] = briefLite(img1_in);
[locs2, desc2] = briefLite(img2_in);
matches = briefMatch(desc1, desc2);
p1 = (locs1(matches(:,1), 1:2))';
p2 = (locs2(matches(:,2), 1:2))';
H = computeH(p1, p2);
HR = ransacH(matches, locs1, locs2);
panoImg_withoutRansac = imageStitching(im1, im2, H);
panoImg_withRansac = imageStitching(im1, im2, HR);

panoImg_withoutRansac_NoClipping = imageStitching_noClip(im1, im2, H);
panoImg_withRansac_NoClipping = imageStitching_noClip(im1, im2, HR);

im3 = panoImg_withRansac_NoClipping;

% imwrite(panoImg_withoutRansac, '../results/panoImg_withoutRansac.jpg');
% imwrite(panoImg_withRansac, '../results/panoImg_withRansac.jpg');
% imwrite(panoImg_withoutRansac_NoClipping, '../results/panoImg_withoutRansac_NoClipping.jpg');
% imwrite(panoImg_withRansac_NoClipping, '../results/panoImg_withRansac_NoClipping.jpg');
% imshow(panoImg_withoutRansac);
% figure;
% imshow(panoImg_withRansac);
% figure;
% imshow(panoImg_withoutRansac_NoClipping);
% figure;
% imshow(panoImg_withRansac_NoClipping);
end

