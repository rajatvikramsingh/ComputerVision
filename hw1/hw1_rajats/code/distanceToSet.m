function [histInter] = distanceToSet(wordHist, histograms)
histInter = sum(min(repmat(wordHist', 1, 1331), histograms));
end
