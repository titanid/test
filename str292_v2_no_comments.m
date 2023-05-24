img = imread('tomo.jpg'); 
img_gray = img; 
figure;
imshow(img_gray); 
filtered_img = imsharpen(img_gray); 
bw_img = imbinarize(filtered_img, 'adaptive'); 
boundaries = bwboundaries(bw_img); 
figure;
imshow(img);
hold on;
for i = 1:length(boundaries)
boundary = boundaries{i};
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
end
hold off;
imwrite(bw_img, 'output_image.jpg'); 
disp(['Найдено ' num2str(length(boundaries)) ' объектов']); 
figure;
subplot(1,2,1);
imshow(img_gray);
title('Исходное изображение');
subplot(1,2,2);
imshow(bw_img);
title('Бинаризованное изображение');
areas = zeros(length(boundaries), 1);
for i = 1:length(boundaries)
boundary = boundaries{i};
areas(i) = polyarea(boundary(:,2), boundary(:,1));
end
total_area = sum(areas);
disp(['Общая площадь найденных объектов: ' num2str(total_area)]);
tic; 
toc; 