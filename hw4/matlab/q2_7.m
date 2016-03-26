clear;
close all;
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load ../data/intrinsics.mat
load ../data/some_corresp.mat
load ../data/templeCoords.mat
load ./q2_5.mat

M = max(size(im1));
F = eightpoint(pts1, pts2, M);
% E = essentialMatrix(F, K1, K2);
M1 = [eye(3), zeros(3,1)];
% M2 = camera2(E);
M1 = K1*M1;
% for i=1:size(canM2, 3)
%     canM2(:, :, i) = K2*canM2(:, :, i);
%     [P, error] = triangulate(M1, pts1, canM2(:,:,i), pts2);
%     temp = P(:,3);
%     if (nnz(P(:,3) < 0) == 0)
%         M2 = canM2(:,:,i);
%     end
% end
x2 = zeros(size(x1));
y2 = zeros(size(y1));
for i=1:size(x1, 1)
    [ x2(i, :), y2(i, :) ] = epipolarCorrespondence( im1, im2, F, x1(i, :), y1(i, :));
end
p1 = [x1, y1];
p2 = [x2, y2];
[P, error] = triangulate(M1, p1, M2, p2);
scatter3(P(:,1), P(:,2), P(:,3));