function select_patches()
template_images_pos = cell(6, 1);
template_images_neg = cell(120, 1);
k = 0;
for i=1:6
    I = imread(['../data/test' num2str(i) '.jpg']);
    imshow(I);
    rect = getrect;
    if (rect(3) < rect(4))
        side = rect(3);
    else
        side = rect(4);
    end
    patch = I(rect(2) + 1: rect(2) + side, rect(1) + 1: rect(1) + side);
    patch = imresize(patch, [128 128]);
    template_images_pos{i} = patch;
    
    for j=1:20
        done = 0;
        while(done ~= 1)
            x = randi([1 + 128, size(I, 1) - 128]);
            y = randi([1 + 128, size(I, 2)] - 128);
            %if ((x + side < rect(2) + 1 && x + 1 < rect(2)) && (y + 1 > rect(1) || y + side > rect(1)))
            if (~(rect(2) + side > x && x > rect(2) + 1 && rect(1) + side > y && y > rect(1) + 1))
                negpatch = I(x + 1: x + 128, y + 1: y + 128);
                %negpatchcell = mat2cell(negpatch);
                template_images_neg{k+j} = negpatch;
                %template_images_neg(k + j, :) = negpatch(:);
                done = 1;
            end
        end
        
    end
    k = k + j;
    close all;
end

save('template_images_pos.mat','template_images_pos')
save('template_images_neg.mat','template_images_neg')


end

