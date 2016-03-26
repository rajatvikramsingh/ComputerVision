load(fullfile('..','data','sylvseq.mat'));
load(fullfile('..','data','sylvbases.mat'));
rect = [102; 62; 156; 108];
rect1 = rect;
rect2 = rect;
saveFrames = [1 200 300 350 400];
rects = zeros(size(frames, 3), 4);
for i=1:size(frames, 3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    [u1, v1] = LucasKanade(It, It1, rect1);
    [u2, v2] = LucasKanadeBasis(It, It1, rect2, bases);
    rect1 = rect1 + [u1 v1 u1 v1]';
    rect1 = round(rect1);
    rect2 = rect2 + [u2 v2 u2 v2]';
    rect2 = round(rect2);
    rects(i, :) = rect2;
    imshow(It1);
    hold on;
    rectangle('Position', [rect1(1) rect1(2) (rect1(3)- rect1(1)) (rect1(4) - rect1(2))], 'EdgeColor', 'yellow');
    rectangle('Position', [rect2(1) rect2(2) (rect2(3)- rect2(1)) (rect2(4) - rect2(2))], 'EdgeColor', 'green');
    hold off;
    if (ismember(i, saveFrames))
        f=getframe(gca);
        [X, map] = frame2im(f);
        imwrite(X, ['../results/LKBasis' num2str(i) '.jpg'],'jpeg');
    end
    pause(.01);
end
save(fullfile('..','results','sylvseqrects.mat'), 'rects');
