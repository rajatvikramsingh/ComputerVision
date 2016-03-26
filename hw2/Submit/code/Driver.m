im = imread('../data/model_chickenbroth.jpg');
im = rgb2gray(im);
im = im2double(im);

sigma0=1;
k=sqrt(2);

levels = [-1 0 1 2 3 4];
th_contrast=0.03;
th_r = 12;

[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
[locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);

p1 = (locs1(matches(:,1), 1:2))';
p2 = (locs2(matches(:,2), 1:2))';

im1 = imread('../../data/incline_L.png');
im2 = imread('../../data/incline_R.png');

img1 = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');

im1 = rgb2gray(img1);
im1 = im2double(im1);

im2 = rgb2gray(img2);
im2 = im2double(im2);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
plotMatches(img1, img2, matches, locs1, locs2);
p1 = (locs1(matches(:,1), 1:2))';
p2 = (locs2(matches(:,2), 1:2))';
H = computeH(p1, p2);
imageStitching(img1, img2, H);

    