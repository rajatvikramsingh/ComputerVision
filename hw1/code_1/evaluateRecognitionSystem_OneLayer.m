source = '../dat/';
target = '../dat/';

matfilepath = 'vision2.mat';
dictfilepath = 'dictionary.mat';
testfilepath = [source, 'traintest.mat'];
load(matfilepath);
load(dictfilepath);
load(testfilepath);

csize = size(mapping, 2);
confuseMat = zeros(csize);
l = length(test_imagenames);

for i=1:l
    fprintf('Recognizing %s\n', test_imagenames{i});
    originalLabel = test_labels(i);
    guessedImage = guessImage([source, test_imagenames{i}]);
    guessedLabel = strmatch(guessedImage, mapping);
    fprintf('Guessed Label %d, original Label %d\n', guessedLabel, originalLabel);
    confuseMat(originalLabel, guessedLabel) = confuseMat(originalLabel, guessedLabel) + 1;
end
accuracy = trace(confuseMat) / sum(confuseMat(:));
accuracy