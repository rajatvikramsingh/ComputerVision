function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
[filterBank] = createFilterBank();
alpha = 100;
filter_responses = zeros(alpha*size(image_names, 2), 3 * size(filterBank, 1));
for i=1:size(image_names, 2)
    i
    image_names{i}
    im = imread(image_names{i});
    filterResponses = extractFilterResponses(im, filterBank);
    randomIndex = randperm(size(filterResponses, 1), alpha);
    filter_responses((i-1) * alpha +1: (i-1) * alpha + alpha, :) = filterResponses(randomIndex, :); %is this efficient
end

K = 200;
[~, dictionary] = kmeans(filter_responses, K, 'EmptyAction','drop');
