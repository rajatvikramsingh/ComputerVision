function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A

out_width = out_size(1);
out_height = out_size(2);
[Xp,Yp] = meshgrid(1:out_height, 1:out_width);

% Xp = Xp';
% Yp = Yp';

n = out_width*out_height;
X = A \ [ Yp(:) Xp(:) ones(n,1) ]';

warp_im = zeros(out_width, out_height);
reX = reshape( X(1,:),out_height,out_width)';
reY = reshape( X(2,:),out_height,out_width)';
warp_im(:,:) = interp2(im(:,:), reX, reY, 'linear');
imshow(warp_im);