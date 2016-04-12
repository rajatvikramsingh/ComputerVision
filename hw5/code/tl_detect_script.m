function tl_detect_script

load('template_images_pos.mat');
load('template_images_neg.mat');

%for i=1:6
%    Itest = imread(['../data/test' num2str(i) '.jpg']);
    Itest = imread('../data/test12.jpg');
    Itest = rgb2gray(Itest);
    Itest = im2double(Itest);
    ndet = 5;
    lambda = 5;
    
%     template = tl_pos(template_images_pos);
%     [x,y,score] = detect(Itest,template,ndet);
%     draw_detection(Itest, ndet, x, y, ones(1, size(x, 2)));
    
    template = tl_pos_neg(template_images_pos, template_images_neg);
    [x,y,score] = detect(Itest,template,ndet);
    draw_detection(Itest, ndet, x, y, ones(1, size(x, 2)));
     
%     template = tl_lda(template_images_pos, template_images_neg, lambda);
%     [x,y,score] = detect(Itest,template,ndet);
%     draw_detection(Itest, ndet, x, y, ones(1, size(x, 2)));
     
    det_res = multiscale_detect(Itest, template, ndet);
    draw_detection(Itest, ndet, det_res(:,1), det_res(:,2), det_res(:,3));
    
end
%end

function draw_detection(Itest, ndet, x, y, scale)
% please complete this function to show the detection results
figure; clf; imshow(Itest);
for i = 1:ndet
    % draw a rectangle.  use color to encode confidence of detection
    %  top scoring are green, fading to red
    hold on;
    h = rectangle('Position',[floor(x(i))-64/scale(i) floor(y(i))-64/scale(i) floor(128/scale(i)) floor(128/scale(i))],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]);
    hold off;
end

end