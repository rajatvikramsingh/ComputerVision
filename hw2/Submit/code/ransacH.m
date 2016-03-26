function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
%RANSACH Summary of this function goes here
%   Detailed explanation goes here
maxIn = 0;
if ~exist('nIter', 'var') || isempty(nIter)
    nIter = 1000;
end
if ~exist('tol', 'var') || isempty(tol)
    tol = 10;
end
for i=1:nIter
    match = randperm(size(matches, 1), 4);
    p1 = (locs1(matches(match,1), 1:2))';
    p2 = (locs2(matches(match,2), 1:2))';
    H = computeH(p1, p2);
    mlocs2 = locs2;
    mlocs2(matches(:,2), 3) = ones(size(matches(:,2), 1), 1);
    projLocs2 = H * mlocs2(matches(:,2), :)';
    projLocs2(1,:) = projLocs2(1,:)./projLocs2(3,:);
    projLocs2(2,:) = projLocs2(2,:)./projLocs2(3,:);
    distance = pdist2(locs1(matches(:,1), :), projLocs2');
    distD = diag(distance);
    inliers = nnz(find(distD<tol));
    if (inliers > maxIn)
        maxIn = inliers;
        bestH = H;
    end
end
end

