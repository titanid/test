im = imread('tomo.jpg');
im_gray = im;
sigma = 2; 
im_blurred = imgaussfilt(im_gray, sigma);
[grad_x, grad_y] = gradient(double(im_blurred));
grad_magnitude = sqrt(grad_x.^2 + grad_y.^2);
grad_magnitude_norm = (grad_magnitude - min(grad_magnitude(:))) / (max(grad_magnitude(:)) - min(grad_magnitude(:)));
binarization_threshold = 0.5;
binary_image = imbinarize(grad_magnitude_norm, binarization_threshold);
se = strel('disk', 2);
binary_image_clean = imopen(binary_image, se);
distance_map = bwdist(~binary_image_clean);
distance_map_norm = (distance_map - min(distance_map(:))) / (max(distance_map(:)) - min(distance_map(:)));
distance_map_ext = imhmax(distance_map_norm, 0.5);
watershed_labels = watershed(-distance_map_ext);
overlay = imoverlay(im, watershed_labels == 0, [1 0 0]);
figure;
subplot(2,2,1);
imshow(im);
title('Исходное изображение');
subplot(2,2,2);
imshow(binary_image_clean);
title('Бинаризованное изображение');
subplot(2,2,3);
imshow(distance_map_norm);
title('Нормализованная карта расстояний');
subplot(2,2,4);
imshow(overlay);
title('Результат сегментации по водоразделам');
figure;
subplot(1,2,1);
histogram(binary_image_clean(:));
title('Гистограмма binary_image_clean');
subplot(1,2,2);
histogram(distance_map_norm(:));
title('Гистограмма distance_map_norm');