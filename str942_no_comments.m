I = imread('tomo.jpg'); 
I_gray = I;
threshold = graythresh(I_gray);
I_bin = imbinarize(I_gray, threshold);
[labels, num] = bwlabel(I_bin);
properties = regionprops(labels, 'Area', 'BoundingBox', 'Centroid');
max_area = max([properties.Area]);
max_area_components = find([properties.Area] == max_area);
figure;
subplot(2, 2, 1);
imshow(I);
title('Исходное изображение');
subplot(2, 2, 2);
imshow(I_bin);
title('Сегментированное изображение');
subplot(2, 2, 3);
imshow(I);
hold on;
for i = 1:length(max_area_components)
idx = max_area_components(i);
rectangle('Position', properties(idx).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
plot(properties(idx).Centroid(1), properties(idx).Centroid(2), 'r*', 'LineWidth', 2);
end
title('Максимально крупные признаки');
subplot(2, 2, 4);
disp(['Количество связных компонент: ', num2str(num)]);
disp(['Максимальная площадь: ', num2str(max_area)]);
disp(['Количество максимально крупных признаков: ', num2str(length(max_area_components))]);
title('Результаты анализа');