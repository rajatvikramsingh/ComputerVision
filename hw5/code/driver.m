I = imread('../data/test0.jpg');
I = im2double(I);
I = rgb2gray(I);
[mag, ori] = mygradient(I);
