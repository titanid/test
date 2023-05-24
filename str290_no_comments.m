I = imread('tomo.jpg');
Igray = I;
threshold = graythresh(Igray);
Ibw = im2bw(Igray, threshold);
[B, L] = bwboundaries(Ibw, 'noholes');
stats = regionprops('table', L, 'Centroid');
centroid = stats.Centroid(1,:);
figure;
imshow(I);
hold on;
plot(B{1}(:,2), B{1}(:,1), 'b', 'LineWidth', 1);
plot(centroid(1), centroid(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Обнаружение объекта и его центра');
object_center = centroid;
object_area = stats.Area(1);
disp(['Площадь объекта: ', num2str(object_area)]);
binary_image = Ibw;
figure;
subplot(1,2,1);
imshow(I);
title('Входное изображение');
subplot(1,2,2);
imshow(binary_image);
title('Бинаризованное изображение');