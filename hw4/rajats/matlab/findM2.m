% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat
clear;
close all;
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load ../data/intrinsics.mat
load ../data/some_corresp.mat
M = max(size(im1));

%sevenpoint( pts1, pts2, M );
F = eightpoint(pts1, pts2, M);
E = essentialMatrix(F, K1, K2);
M1 = [eye(3), zeros(3,1)];
canM2 = camera2(E);
M1 = K1*M1;
M2 = zeros(size(canM2, 1), size(canM2, 2));
for i=1:size(canM2, 3)
    canM2(:, :, i) = K2*canM2(:, :, i);
    [P, ~] = triangulate(M1, pts1, canM2(:,:,i), pts2);
    temp = P(:,3);
    if (nnz(P(:,3) < 0) == 0)
        M2 = canM2(:,:,i);
    end
end
p1 = pts1;
p2 = pts2;
[P, error] = triangulate(M1, p1, M2, p2);
save('q2_5.mat', 'M1', 'M2', 'p1', 'p2', 'P');