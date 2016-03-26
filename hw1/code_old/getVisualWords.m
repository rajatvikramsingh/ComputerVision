function [wordMap] = getVisualWords(I, filterBank, dictionary)
filterResponse = extractFilterResponses(I, filterBank);
wordMapSingle = zeros(size(filterResponse, 1), 1);
for i=1:size(filterResponse, 1)
    distance = pdist2(filterResponse(i, :), dictionary);
    [~, tag] = min(distance);
    wordMapSingle(i) = tag;
end
wordMap = reshape(wordMapSingle, size(I, 1), size(I, 2));
end