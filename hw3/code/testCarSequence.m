
load(fullfile('..','data','carseq.mat')); % variable name = frames.
figure;
rect = [60; 117; 146; 152];
rects = zeros(size(frames, 3), 4);
saveFrames = [1 100 200 300 400];
for i=1:size(frames, 3)-1
    It = frames(:,:,i);
    It1 = frames(:,:,i+1);
    [u, v] = LucasKanade(It, It1, rect);
    rect = rect + [u v u v]';
    rect = round(rect);
    rects(i, :) = rect;
    imshow(It1);
    hold on;
    rectangle('Position', [rect(1) rect(2) (rect(3)- rect(1)) (rect(4) - rect(2))], 'EdgeColor', 'yellow');
    hold off;
    if (ismember(i, saveFrames))
        f=getframe(gca);
        [X, map] = frame2im(f);
        imwrite(X, ['../results/LK' num2str(i) '.jpg'],'jpeg');
    end
    pause(.01);
end
% save the rects
save(fullfile('..','results','carseqrects.mat'),'rects');
