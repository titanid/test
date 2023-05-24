im = imread('tomo.jpg');
im_gray = im;
sigma = 2; 
im_blurred = imgaussfilt(im_gray, sigma);
[grad_x, grad_y] = gradient(double(im_blurred));
grad_magnitude = sqrt(grad_x.^2 + grad_y.^2);
grad_magnitude_norm = (grad_magnitude - min(grad_magnitude(:))) / (max(grad_magnitude(:)) - min(grad_magnitude(:)));
disp(['Min, Max и Mean значения нормализованных градиентов: ', num2str(min(grad_magnitude_norm(:))), ', ', num2str(max(grad_magnitude_norm(:))), ', ', num2str(mean(grad_magnitude_norm(:)))])
binarization_threshold = 0.5;
binary_image = imbinarize(grad_magnitude_norm, binarization_threshold);
disp(['Процент пикселей, превышающих порог бинаризации: ', num2str(100*mean(binary_image(:))), '
se = strel('disk', 2);
binary_image_clean = imopen(binary_image, se);
distance_map = bwdist(~binary_image_clean);
distance_map_norm = (distance_map - min(distance_map(:))) / (max(distance_map(:)) - min(distance_map(:)));
disp(['Min, Max и Mean значения нормализованных расстояний: ', num2str(min(distance_map_norm(:))), ', ', num2str(max(distance_map_norm(:))), ', ', num2str(mean(distance_map_norm(:)))])
distance_map_ext = imhmax(distance_map_norm, 0.5);
watershed_labels = watershed(-distance_map_ext);
disp(['Число найденных регионов водораздела: ', num2str(max(watershed_labels(:)))])