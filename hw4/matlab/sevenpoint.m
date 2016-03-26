function [F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
T = [1/M 0 0; 0 1/M 0; 0 0 1];

randpts = randperm(size(pts1, 1), 7);
pts1 = pts1(randpts, :);
pts2 = pts2(randpts, :);

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
[U, S, V] = svd(A);
F1 = reshape(V(:, size(V, 2) - 1), 3, 3)';
F2 = reshape(V(:, size(V, 2)), 3, 3)';

syms a
eqn = (det(a*F1 + (1-a)*F2) == 0);
sol = solve(eqn, a);
sol = simplify(sol);
sol = double(sol);

F = cell(1);
for i=1:size(sol, 1)
    tempF = real(sol(i,:))*F1 + (1 - real(sol(i,:)))*F2;
    [uf, sf, vf] = svd(tempF);
    sf(3) = 0;
    tempF = uf*sf*vf';
    tempF = refineF(tempF, normpts1(:,1:2), normpts2(:,1:2));
    F{i} = T'*tempF*T;
end
save('q2_2.mat', 'F', 'M', 'pts1', 'pts2');