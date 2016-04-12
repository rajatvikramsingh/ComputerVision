function template = tl_lda(template_images_pos, template_images_neg, lambda)
% input:
%     template_images_pos - a cell array, each one contains [16 x 16 x 9] matrix
%     template_images_neg - a cell array, each one contains [16 x 16 x 9] matrix
%     lambda - parameter for lda
% output:
%     template - [16 x 16 x 9] matrix 

sumph = 0;
for i=1:size(template_images_neg, 1);
    patch = template_images_neg{i};
    sumph = sumph + hog(double(patch));
end

templateNeg = sumph./size(template_images_neg, 1);

sumTerm = zeros(size(templateNeg));
for i=1:size(template_images_neg, 1)
    temp = hog(template_images_neg{i});
    diff = double(temp) - templateNeg;
    mult = diff .* permute(diff, [2 1 3]);
    sumTerm = sumTerm + mult;
end

covFinal = sumTerm ./ size(template_images_neg, 1);

reg = lambda .* repmat(eye(size(sumTerm, 1), size(sumTerm, 2)), [1, 1, size(sumTerm, 3)]);
covFinal = covFinal + reg;

invCovFinal = zeros(size(covFinal));
for i=1:size(covFinal, 3)
    invCovFinal(:, :, i) = inv(covFinal(:,:, i));
end
template = invCovFinal .* tl_pos_neg(template_images_pos, template_images_neg);

end