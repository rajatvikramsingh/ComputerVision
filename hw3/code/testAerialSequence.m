load(fullfile('..','data','aerialseq.mat'));
saveFrames = [30, 60, 90, 120];
rects = zeros(size(frames, 3), 4);
for i=1:size(frames, 3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    subMask = SubtractDominantMotion(It, It1);
    finImage = imfuse(subMask, It1, 'falsecolor','Scaling','joint','ColorChannels',[1 2 1]);
    imshow(finImage);
    if (ismember(i, saveFrames))
        f=getframe(gca);
        [X, map] = frame2im(f);
        imwrite(X, ['../results/LKAffine' num2str(i) '.jpg'],'jpeg');
    end
    pause(.01);
end
%save(fullfile('..','results','aerialseqrects.mat','rects'));
