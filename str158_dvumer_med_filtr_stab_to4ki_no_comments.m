img = imread('tomo.jpg');
grayImg = im2double(img);
medianImg = medfilt2(grayImg, [3 3]);
[dx, dy] = gradient(medianImg);
ddx = gradient(dx);
ddy = gradient(dy);
dxy = 0.5*(gradient(dx(:,1))+gradient(dy(1,:)));
stablePoints = (dx.*ddy - dy.*dxy) ./ ((dx.^2 + dy.^2).^(3/2));
maxVal = max(max(stablePoints));
normalizedStablePoints = stablePoints ./ maxVal;
figure;
subplot(1,2,1);
imshow(img);
title('Исходное изображение');
subplot(1,2,2);
imshow(normalizedStablePoints);
title('Стабильные точки');
outputImg = normalizedStablePoints;