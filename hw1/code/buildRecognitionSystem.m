load('../dat/traintest.mat');
l = length(train_imagenames);
source = '../dat/';
target = '../dat/';
layerNum=3;
dictionarySize = size(dictionary, 2);
train_features = zeros((dictionarySize * ((4^(layerNum))-1)/3), l);
for i=1:l
    fprintf('Extracting Features %s\n', train_imagenames{i});
    image = imread([source, train_imagenames{i}]);
    matfilepath = strrep([source, train_imagenames{i}], '.jpg', '.mat');
    load(matfilepath, 'wordMap');
    h = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    %h = getImageFeatures(
    train_features(:, i) = h;
end
save('vision.mat','filterBank', 'dictionary','train_features', 'train_labels');