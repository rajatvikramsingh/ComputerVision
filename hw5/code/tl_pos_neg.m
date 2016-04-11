function template = tl_pos_neg(template_images_pos, template_images_neg)
% input:
%     template_images_pos - a cell array, each one contains [16 x 16 x 9] matrix
%     template_images_neg - a cell array, each one contains [16 x 16 x 9] matrix
% output:
%     template - [16 x 16 x 9] matrix 

sumph = 0;
for i=1:size(template_images_neg);
    patch = template_images_neg{i};
    sumph = sumph + hog(patch);
end

templateNeg = sumph./size(template_images_neg, 1);
templatePos = tl_pos(template_images_pos);

template = templatePos - templateNeg;

end