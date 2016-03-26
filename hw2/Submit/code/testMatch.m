im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

img1 = im2double(im1);
if size(im1,3)==3
    img1= rgb2gray(img1);
end
img2 = im2double(im2);
if size(img2,3)==3
    img2= rgb2gray(img2);
end

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
plotMatches(img1, img2, matches, locs1, locs2);
