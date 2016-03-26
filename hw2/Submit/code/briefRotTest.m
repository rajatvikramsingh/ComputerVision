im1 = imread('../data/model_chickenbroth.jpg');
im2 = im1;
[locs1, desc1] = briefLite(im1);
matchVector = zeros(36, 1);
for i=0:36
    imRot = imrotate(im2, i*10);
    [locs2, desc2] = briefLite(imRot);
    matches = briefMatch(desc1, desc2);
    matchVector(i+1) = size(matches, 1);
end
bar(matchVector)
