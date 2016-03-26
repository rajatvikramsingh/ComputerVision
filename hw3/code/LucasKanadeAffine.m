function M = LucasKanadeAffine(It, It1)
Itgrey = im2double(It);
It1grey = im2double(It1);
[gridx, gridy] = meshgrid(1:size(Itgrey,1), 1:size(Itgrey, 2));
[xT, yT] = imgradientxy(Itgrey);
delT = [xT(:) yT(:)];


sd(:,1) = xT(:).*gridx(:);
sd(:,2) = yT(:).*gridx(:);
sd(:,3) = xT(:).*gridy(:);
sd(:,4) = yT(:).*gridy(:);
sd(:,5) = xT(:);
sd(:,6) = yT(:);

H = (sd)'*(sd);
p = [0 0 0 0 0 0]';

err = 1000;
while err >  0.05
    M = [[1+p(1) p(3) p(5)]; [p(2) 1+p(4) p(6)]; [0 0 1]];
    warpedIt = warpH(It1grey, M, size(It1grey));
    errorI = warpedIt - Itgrey;
    temp = sd' * errorI(:);
    delP = H \ temp;
    p = p + delP;
    err = norm(delP);
end
end

