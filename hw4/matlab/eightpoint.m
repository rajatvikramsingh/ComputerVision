function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

T = [1/M 0 0; 0 1/M 0; 0 0 1];
normpts1 = ([pts1, ones(size(pts1, 1), 1)]) * T;
normx1 = normpts1(:,1);
normy1 = normpts1(:,2);

normpts2 = [pts2, ones(size(pts2, 1), 1)] * T;
normx2 = normpts2(:,1);
normy2 = normpts2(:,2);

x1x2 = normx1.*normx2;
y1x2 = normy1.*normx2;
x1y2 = normx1.*normy2;
y1y2 = normy1.*normy2;

A = [x1x2, y1x2, normx2, x1y2, y1y2, normy2, normx1, normy1, ones(size(normx1))];
[~, ~, V] = svd(A);
F = reshape(V(:,9), 3, 3)';
[uf, sf, vf] = svd(F);
sf(3) = 0;
F = uf*sf*vf';
F = refineF(F, normpts1(:,1:2), normpts2(:,1:2));
F = T'*F*T;
save('q2_1.mat', 'F', 'M', 'pts1', 'pts2');
end

