function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%
x1 = p1(:,1);
y1 = p1(:,2);

x2 = p2(:,1);
y2 = p2(:,2);

for i=1:size(p1, 1)
    A(1, :) = (y1(i,:)*M1(3,:)' - M1(2,:)');
    A(2, :) = (M1(1,:)' - x1(i,:)*M1(3,:)');
    A(3, :) = (y2(i,:)*M2(3,:)' - M2(2,:)');
    A(4, :) = (M2(1,:)' - x2(i,:)*M2(3,:)');
    
    [U, S, V] = svd(A);
    M = V(:,4);
    P(i,:) = M/M(4);
end

temp1 = P*M1';
temp2 = P*M2';

error = sum((p1 - temp1(:,1:2)).^2 + (p2 - temp2(:,1:2)).^2);
P = P(:, 1:3);
end

