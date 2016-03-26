clear;
close all;
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load ../data/some_corresp.mat
load ../data/intrinsics.mat
M = max(size(im1));

randpts = randperm(size(pts1, 1), 7);
pts1 = pts1(randpts, :);
pts2 = pts2(randpts, :);
F = cell(1);
F = sevenpoint( pts1, pts2, M );
F = eightpoint(pts1, pts2, M);
E = essentialMatrix(F, K1, K2);
M1 = [eye(3), zeros(3,1)];
M2 = camera2(E);
M1 = K1*M1;
for i=1:size(M2, 1)
    M2(:, :, i) = K2*M2(:, :, i);
end
[P, error] = triangulate(M1, pts1, M2(:,:,1), pts2);
scatter3(P);