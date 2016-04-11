function ohist = hog(I)
%
% compute orientation histograms over 8x8 blocks of pixels
% orientations are binned into 9 possible bins
%
% I : grayscale image of dimension HxW
% ohist : orinetation histograms for each block. ohist is of dimension (H/8)x(W/8)x9
% TODO

% normalize the histogram so that sum over orientation bins is 1 for each block
%   NOTE: Don't divide by 0! If there are no edges in a block (ie. this counts sums to 0 for the block) then just leave all the values 0.
% TODO

height = size(I, 1);
width = size(I, 2);

hmod = mod(height, 8);
wmod = mod(width, 8);

if (hmod == 0)
    hmod = 8;
end
if (wmod == 0)
    wmod = 8;
end
finalI = zeros(height + 8 - hmod, width + 8 - wmod);

finalI(1:height, 1:width) = I;
[mag, ~] = mygradient(finalI);
thresh = 0.1*max(mag(:));
ohist = zeros(size(finalI, 1)/8, size(finalI, 2)/8, 9);

% B = im2col(I, [8 8], 'distinct');
% 
% for i=1:size(B, 2)
%     block = reshape(B(:,i), 8, 8);
%     [mag, ori] = mygradient(block);
%     [row, col] = find(mag > thresh);
%     fOri = ori(sub2ind(size(ori),row,col));
%     histg = hist(fOri, 9);
%     histg = histg/sum(histg);
%     ohist(i + 1, j + 1, :) = histg;
% end

for i=0:(size(finalI, 1)/8) - 1
    for j=0:(size(finalI, 2)/8) - 1
        [mag, ori] = mygradient(finalI(i*8 + 1:(i*8)+8, j*8+1:(j*8)+8));
        [row, col] = find(mag > thresh);
        fOri = ori(sub2ind(size(ori),row,col));
        [row, col] = find(fOri ~= 0);
        fOri = fOri(sub2ind(size(fOri),row,col));
        histg = hist(fOri, 9) + ones(1, 9);
        histg = histg/sum(histg);
        ohist(i + 1, j + 1, :) = histg;
    end
end
