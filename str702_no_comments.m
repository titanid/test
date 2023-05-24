A = imread('tomo.jpg');
polutonovoe_izobrazhenie = A;
binarnoe_izobrazhenie = imbinarize(polutonovoe_izobrazhenie);
strelka = strel('disk', 2);
erosion = imerode(binarnoe_izobrazhenie, strelka);
dilation = imdilate(binarnoe_izobrazhenie, strelka);
opening = imopen(binarnoe_izobrazhenie, strelka);
closing = imclose(binarnoe_izobrazhenie, strelka);
granitsy = bwboundaries(binarnoe_izobrazhenie);
subplot(2, 3, 1);
imshow(polutonovoe_izobrazhenie);
title('Полутоновое изображение');
subplot(2, 3, 2);
imshow(binarnoe_izobrazhenie);
title('Бинарное изображение');
subplot(2, 3, 3);
imshow(binarnoe_izobrazhenie);
title('Бинарное изображение после морфологической обработки');
subplot(2, 3, 4);
imshow(erosion);
title('Erosion');
subplot(2, 3, 5);
imshow(dilation);
title('Dilation');
subplot(2, 3, 6);
imshow(opening);
title('Opening');
subplot(2, 3, 6);
imshow(closing);
title('Closing');
figure;
imshow(polutonovoe_izobrazhenie);
hold on;
for k = 1:length(granitsy)
boundary = granitsy{k};
plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
end
title('Границы объектов');