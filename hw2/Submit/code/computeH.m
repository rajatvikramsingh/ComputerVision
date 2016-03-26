function H2to1 = computeH(p1,p2)
%COMPUTEH Summary of this function goes here
%   Detailed explanation goes here
n = size(p1, 2);
h=[];
for i=1:n
    x1 = p1(1, i)'; y1 = p1(2,i)'; x2 = p2(1,i)'; y2 = p2(2,i)';
    rows0 = zeros(1, 3);
    rowsXY = -[x2, y2, 1];
    hx = [rowsXY, rows0, x1.*x2, x1.*y2, x1];
    hy = [rows0, rowsXY, y1.*x2, y1.*y2, y1];
    h = [h; [hx; hy]];
end
[~, ~, V] = svd(h);
H2to1 = (reshape(V(:,9), 3, 3))';
end
