function [ score ] = ncc(image1, image2)
%NCC function, returns the score
dimage1 = double(image1);
dimage2 = double(image2);

num = sum(sum(dimage1' * dimage2));
den = sqrt((sum(sum(dimage1' * dimage1))) * (sum(sum(dimage2' * dimage2))));
score = num / den;
end

