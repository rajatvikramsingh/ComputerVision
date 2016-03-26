% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = load('../data/red.mat');
green = load('../data/green.mat');
blue = load('../data/blue.mat');
% Red channel as 'red'
% Green channel as 'green'
% Blue channel as 'blue'
red = red.red;
blue = blue.blue;
green = green.green;
%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
outname = fullfile('../results/','rgb_output.jpg');
%saveas(rgbResult, outname);
imwrite(rgbResult, outname, 'jpg');
