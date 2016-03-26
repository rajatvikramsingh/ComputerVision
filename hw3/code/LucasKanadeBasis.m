function [u, v] = LucasKanadeBasis(It, It1, rect, basis)
greyIt = im2double(It);
greyIt1 = im2double(It1);
[gridx, gridy] = meshgrid(rect(1):rect(3), rect(2):rect(4));
template = interp2(greyIt, gridx, gridy);
[xT, yT] = gradient(template);
delT = [xT(:) yT(:)];
sum=zeros(size(xT));
for i=1:size(basis, 3)
    sum = sum + basis(:,:,i) .* xT;
end

sum2=zeros(size(xT));
for i=1:size(basis, 3)
    sum2 = sum2 + basis(:,:,i) .* sum;
end

sum3=zeros(size(xT));
for i=1:size(basis, 3)
    sum3 = sum3 + basis(:,:,i) .* yT;
end

sum4=zeros(size(xT));
for i=1:size(basis, 3)
    sum4 = sum4 + basis(:,:,i) .* sum3;
end
sum5 = [sum2(:) sum4(:)];
diff = delT - sum5;

H = diff'*diff;
p = [0 0];
warp = rect;
err = 1000;
while (err > 0.05)
    warp = round(warp) + [p(1) p(2) p(1) p(2)]';
    [gridx, gridy] = meshgrid((rect(1):rect(3)) + p(1), (rect(2):rect(4)) + p(2));
    temp2 = interp2(greyIt1, gridx, gridy);
    errorI = temp2 - template;
    errorI=double(errorI);
    temp = delT' * double(errorI(:));
    delP = inv(H) * temp;
    p = p - delP';
    err = norm(delP);
end
u=p(1);
v=p(2);
end

