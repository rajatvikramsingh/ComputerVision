function [ paddedWordMap ] = checkPaddedRequired( wordMap, layer )

remh=rem(size(wordMap, 1),(2^layer));
remw=rem(size(wordMap, 2),(2^layer));

extrah=0;
extraw=0;
if(remh~=0)
    extrah = (2^layer) - remh;
end
if(remw~=0)
    extraw = (2^layer) - remw;
end

paddedWordMap = padarray(wordMap, [extrah extraw], 'replicate', 'post');
end

