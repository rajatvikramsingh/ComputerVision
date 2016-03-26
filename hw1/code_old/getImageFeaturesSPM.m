function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
%h = zeros(1, (dictionarySize*(4^(layerNum+1)-1)/3));
h=[];
for i=layerNum:-1:0
    htemp = zeros(1, dictionarySize * (4^i));
    wordMap = checkPaddedRequired( wordMap, i);
    layerh=size(wordMap, 1)/(2^i);
    layerw=size(wordMap, 2)/(2^i);
    cells = mat2cell(wordMap, repmat(layerh, 1, 2^i), repmat(layerw, 1, 2^i));
    
    hcells = cells(:);
    for j=1:size(hcells, 1)
        celltemp = hcells{j};
        histtemp = hist(celltemp(:), dictionarySize);
        htemp(i*dictionarySize + 1: (i+1) * dictionarySize) = histtemp/sum(histtemp);
    end
    if (i==0 || i==1)
        weight = 2^(-layerNum);
    else
        weight = 2^(i-layerNum-1);
    end
    htemp = htemp*weight;
    h = [h htemp];
end