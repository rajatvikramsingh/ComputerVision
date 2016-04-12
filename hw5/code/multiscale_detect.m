function det_res = multiscale_detect(image, template, ndet)
% input:
%     image - test image.
%     template - [16 x 16x 9] matrix.
%     ndet - the number of return values.
% output:
%      det_res - [ndet x 3] matrix
%                column one is the x coordinate
%                column two is the y coordinate
%                column three is the scale, i.e. 1, 0.7 or 0.49 ..

scale = 1;
i = 0;
while ((min(size(image))*scale)/8 > size(template, 1))
    image = imresize(image, scale);
    size(image)
    [x, y, score] = detect(image, template, ndet);
    temp(ndet*i+1 : ndet*i+ndet, 1) = x./scale;
    temp(ndet*i+1 : ndet*i+ndet, 2) = y./scale;
    temp(ndet*i+1 : ndet*i+ndet, 3) = ones(1, ndet) * scale;
    temp(ndet*i+1 : ndet*i+ndet, 4) = score;
    scale
    scale = 0.7 * scale;
    i = i+1;
end

tempscore = temp(:, 4);
[Y, I] = sort(tempscore(:), 'descend');

det_res = zeros(ndet, 3);

j =1;
for i=1:ndet
    done = 0;
    while done~=1 && j<size(I, 1)
        %[y2, x2] = ind2sub(size(temp(:, 4)), I(j));
        x1 = temp(I(j), 1);
        y1 = temp(I(j), 2);
        if nonmaxsuppression(floor(det_res(:, 1)'), floor(det_res(:, 2)'), det_res(:, 3)', floor(x1), floor(y1), temp(I(j), 3)) == 0
            det_res(i, 1) = floor(x1);
            det_res(i, 2) = floor(y1);
            det_res(i, 3) = temp(I(j), 3);
            done = 1;
        end
        j = j+1;
    end
end

end
