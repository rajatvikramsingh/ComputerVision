function guessedImage = guessImage( imagename ) 
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

load(['../dat/' 'vision.mat']);
%fprintf('[Loading..]\n');
image = imread(imagename);
% imshow(image);
%fprintf('[Getting Visual Words..]\n');
wordMap = getVisualWords(image, filterBank, dictionary);
%imagesc(wordMap);figure;
h = getImageFeaturesSPM( 2, wordMap, size(dictionary, 1));
distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../dat/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
%fprintf('[My Guess]:%s %d.\n',guessedImage, nnI);

% figure(1);
% imshow(image);
% title('image to classify')

end

