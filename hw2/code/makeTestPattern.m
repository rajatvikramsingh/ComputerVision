function [ compareX, compareY ] = makeTestPattern(patchWidth, nbits)
%MAKETESTPATTERN Summary of this function goes here
%   Detailed explanation goes here
sigma = (patchWidth^4)/25;
R=mvnrnd([0 0], [sigma 0; 0 sigma], nbits);
compareX = int16(R(:, 1));
compareY = int16(R(:, 2));
save('testPattern.mat', 'compareX', 'compareY');
end
