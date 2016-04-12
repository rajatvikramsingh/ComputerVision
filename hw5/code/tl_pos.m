function template = tl_pos(template_images_pos)
% input:
%     template_images_pos - a cell array, each one contains [16 x 16 x 9] matrix
% output:
%     template - [16 x 16 x 9] matrix

sumph = 0;
for i=1:size(template_images_pos);
    patch = template_images_pos{i};
    sumph = sumph + hog(double(patch));
end

template = sumph./size(template_images_pos, 1);

end