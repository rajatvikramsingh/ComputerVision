load('../dat/traintest.mat');
l = length(train_imagenames);
source = '../dat/';
target = '../dat/';
layerNum=3;
dictionarySize = size(dictionary, 2);
train_features_one = zeros(dictionarySize, l);
for i=1:l
    fprintf('Extracting Features %s\n', train_imagenames{i});
    image = imread([source, train_imagenames{i}]);
    matfilepath = strrep([source, train_imagenames{i}], '.jpg', '.mat');
    load(matfilepath, 'wordMap');
    h = getImageFeatures(wordMap, dictionarySize);
    train_features_one(:, i) = h;
end
save('vision2.mat','filterBank', 'dictionary','train_features_one', 'train_labels');