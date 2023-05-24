img = imread('tomo.jpg');
gray_img = img;
threshold = graythresh(gray_img);
binary_img = imbinarize(gray_img, threshold);
labeled_img = bwlabel(binary_img);
stats = regionprops(labeled_img, 'Centroid');
centroids = cat(1, stats.Centroid);
figure;
imshow(img);
hold on;
plot(centroids(:,1), centroids(:,2), 'r*');
title('Выделенные объекты и их центры на исходном изображении');
sizes = regionprops(labeled_img, 'Area');
areas = cat(1, sizes.Area);
figure;
histogram(areas, 'BinWidth', 50);
title('Гистограмма размеров объектов');
fragment_size = 50;
fragments = im2col(binary_img, [fragment_size fragment_size], 'distinct');
filtered_fragments = arrayfun(@(x)optimal_filter(fragments(:,x)), 1:size(fragments,2), 'UniformOutput', false);
filtered_fragments = cat(2, filtered_fragments{:});
filtered_img = col2im(filtered_fragments, [fragment_size fragment_size], size(binary_img), 'distinct');
figure;
subplot(1,2,1);
imshow(binary_img);
title('Исходное бинарное изображение');
subplot(1,2,2);
imshow(filtered_img);
title('Отфильтрованное бинарное изображение');
output_data = struct('centroids', centroids, 'areas', areas, 'filtered_img', filtered_img);
function [filtered_fragment] = optimal_filter(fragment)
fragment_size = size(fragment, 1);
variance = var(fragment(:));
if variance == 0
filtered_fragment = fragment;
else
kernel_size = min(ceil(variance), fragment_size);
kernel = fspecial('gaussian', kernel_size, variance);
filtered_fragment = imfilter(fragment, kernel, 'conv');
end
end