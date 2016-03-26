function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
%h = zeros(1, (dictionarySize*(4^(layerNum+1)-1)/3));
h=[];
for i=layerNum:-1:1
    htemp = zeros(1, dictionarySize * (4^(i-1)));
    wordMap = checkPaddedRequired( wordMap, (i-1));
    layerh=size(wordMap, 1)/(2^(i-1));
    layerw=size(wordMap, 2)/(2^(i-1));
    cells = mat2cell(wordMap, repmat(layerh, 1, 2^(i-1)), repmat(layerw, 1, 2^(i-1)));
    
    hcells = cells(:);
    for j=1:size(hcells, 1)
        celltemp = hcells{j};
        histtemp = hist(celltemp(:), dictionarySize);
        htemp((i-1)*dictionarySize + 1: i * dictionarySize) = histtemp/sum(histtemp);
    end
    if ((i-1)==0 || (i-1)==1)
        weight = 2^(-layerNum);
    else
        weight = 2^((i-1)-layerNum-1);
    end
    htemp = htemp*weight;
    h = [h htemp];
end