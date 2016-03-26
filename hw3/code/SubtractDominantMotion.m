function mask = SubtractDominantMotion(image1, image2)
mask = LucasKanadeAffine(image1, image2);
warpedImage = warpH(image1, mask, size(image1));
diffImage = image2 - warpedImage;
diffImage(diffImage > 50) = 255;
se = strel('disk', 3);
diffImage = imdilate(diffImage,se);
diffImage = imerode(diffImage, se);
%diffImage = bwareaopen(diffImage, 50);
mask = diffImage;
end
