im = imread('tomo.jpg');
im = im; 
im_norm = double(im) / 255;
[n, x] = hist(im_norm(:), 256);
n = n / sum(n); 
target_hist = ones(1, 256) / 256;
cum_hist = cumsum(n);
cum_target_hist = cumsum(target_hist);
g = zeros(1, 256);
for i = 1:256
[~, ind] = min(abs(cum_hist(i) - cum_target_hist));
g(i) = ind - 1;
end
im_eq = uint8(reshape(g(im_norm(:) * 255 + 1), size(im)));
im_ishod = im; 
im_ravnom = im_eq; 
g_ishod = cum_hist; 
g_ravnom = cum_target_hist; 
figure;
subplot(2, 2, 1);
imshow(im_ishod);
title('Исходное изображение');
subplot(2, 2, 2);
imshow(im_ravnom);
title('Равномерно модифицированное изображение');
subplot(2, 2, 3);
plot(g_ishod);
title('Кумулятивная гистограмма исходного изображения');
xlabel('Значение яркости');
ylabel('Кумулятивная частота');