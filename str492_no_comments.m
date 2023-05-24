im = imread('tomo.jpg');
im_gray = im;
[rows, cols] = size(im_gray);
yarkost = mean(im_gray(:));
kontrast = std(double(im_gray(:)));
im_p = imhist(im_gray) / numel(im_gray);
entropiya = -sum(im_p .* log2(im_p + (im_p==0)));
vyhod_yarkost = yarkost;
vyhod_kontrast = kontrast;
vyhod_entropiya = entropiya;
figure;
bar(1, vyhod_yarkost);
hold on;
bar(2, vyhod_kontrast);
hold off;
title('Сравнение яркости и контраста');
ylabel('Значение');
set(gca, 'XTickLabel', {'Яркость', 'Контраст'});
im_hist = imhist(im_gray);
im_hist_normalized = im_hist / (rows * cols);
im_cum_hist = cumsum(im_hist_normalized);
im_eq = uint8(255 * im_cum_hist(im_gray + 1));
yarkost_eq = mean(im_eq(:));
kontrast_eq = std(double(im_eq(:)));
im_p_eq = imhist(im_eq) / numel(im_eq);
entropiya_eq = -sum(im_p_eq .* log2(im_p_eq + (im_p_eq==0)));
vyhod_yarkost_eq = yarkost_eq;
vyhod_kontrast_eq = kontrast_eq;
vyhod_entropiya_eq = entropiya_eq;
figure;
bar(1:2, [vyhod_yarkost, vyhod_kontrast], 'b');
hold on;
bar(3:4, [vyhod_yarkost_eq, vyhod_kontrast_eq], 'r');
hold off;
title('Сравнение яркости и контраста');
ylabel('Значение');
legend('Оригинальное изображение','Эквализированное изображение', 'Location', 'best');
set(gca, 'XTickLabel', {'Яркость', 'Контраст', 'Яркость (экв.)', 'Контраст (экв.)'});
grid on;
figure;
bar(1, vyhod_entropiya, 'b');
hold on;
bar(2, vyhod_entropiya_eq, 'r');
hold off;
title('Сравнение энтропии');
ylabel('Значение');
legend('Оригинальное изображение', 'Эквализированное изображение', 'Location', 'best');
set(gca, 'XTickLabel', {'Энтропия', 'Энтропия (экв.)'});
grid on;
figure;
subplot(1, 2, 1);
imshow(im_gray);
title('Оригинальное изображение');
subplot(1, 2, 2);
imshow(im_eq);
title('Эквализированное изображение');
figure;
subplot(1, 2, 1);
bar(im_hist);
title('Гистограмма оригинального изображения');
xlabel('Интенсивность');
ylabel('Количество пикселей');
subplot(1, 2, 2);
bar(imhist(im_eq));
title('Гистограмма эквализированного изображения');
xlabel('Интенсивность');
ylabel('Количество пикселей');
grid on;
figure;
bar(vyhod_entropiya);
title('Энтропия изображения');
ylabel('Значение');
set(gca, 'XTickLabel', {'Энтропия'});
grid on;