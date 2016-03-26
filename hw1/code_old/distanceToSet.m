function [histInter] = distanceToSet(wordHist, histograms)
num_images = size(histograms, 2);
histInter = zeros(1, num_images);
for i=1:num_images
    histInter(i) = sum(min(wordHist, histograms(:, i)'));
end
end
