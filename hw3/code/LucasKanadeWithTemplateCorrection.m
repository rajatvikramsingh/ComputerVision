function [u, v] = LucasKanadeWithTemplateCorrection(template, It1, rect)
greyIt1 = im2double(It1);
[xT, yT] = imgradientxy(template, 'CentralDifference');
delT = [xT(:) yT(:)];
H = delT'*delT;
p = [0 0]';
err = 1000;
while (err > 0.05)
    [gridx, gridy] = meshgrid((rect(1):rect(3)) + p(1), (rect(2):rect(4)) + p(2));
    temp2 = interp2(greyIt1, gridx, gridy);
    temp2(isnan(temp2)) = 0;
    errorI = temp2 - template;
    temp = delT' * errorI(:);
    delP = H \ temp;
    p = p - delP;
    err = norm(delP);
end
u=p(1);
v=p(2);
end
