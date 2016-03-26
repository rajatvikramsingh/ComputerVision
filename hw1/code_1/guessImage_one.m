function guessedImage = guessImage_one( imagename ) 
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

load('vision2.mat');
fprintf('[Loading..]\n');
image = im2double(imread(imagename));
% imshow(image);
fprintf('[Getting Visual Words..]\n');
wordMap2 = getVisualWords(image, filterBank, dictionary);
h = getImageFeatures(wordMap2, size(dictionary,2));
distances = distanceToSet(h, train_features_one);
[~,nnI] = max(distances);
nnI
load('../dat/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);

% figure(1);
% imshow(image);
% title('image to classify')

end
