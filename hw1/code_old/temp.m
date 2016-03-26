reshape(filtered, 76800, 3);
reshaped = reshape(filtered, 76800, 3);
size(reshaped)
rr = reshape(reshaped, 320, 240, 3);
imshow(rr)

imageName = ['../dat/' test_imagenames{l-200}];
fprintf('[Loading..]\n');
image = im2double(imread(imagename));
% imshow(image);
fprintf('[Getting Visual Words..]\n');
wordMap = getVisualWords(image, filterBank, dictionary);
h = getImageFeaturesSPM( 2, wordMap, size(dictionary, 1));
distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../dat/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);


I = imread(['../dat/' 'airport/sun_aerinlrdodkqnypz.jpg']);
imagesc(I);
wordMap = getVisualWords(I, filterBank, dictionary);
figure;imagesc(wordMap)