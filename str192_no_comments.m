im_path = 'tomo.jpg';
vkhodnaja_kartinka = imread(im_path);
figure; imshow(vkhodnaja_kartinka); title('Входное изображение');
seroe_izobrazhenie = vkhodnaja_kartinka;
figure; imshow(seroe_izobrazhenie); title('Изображение в оттенках серого');
razmer_jadra = 3; 
jadro_svertki = (1/(razmer_jadra^2)) * ones(razmer_jadra, razmer_jadra);
seroe_izobrazhenie_double = im2double(seroe_izobrazhenie);
jadro_svertki_double = double(jadro_svertki);
usilennoe_izobrazhenie_double = nlfilter(seroe_izobrazhenie_double, [razmer_jadra razmer_jadra], @(b) sum(sum(b.*jadro_svertki_double)));
usilennoe_izobrazhenie = im2uint8(usilennoe_izobrazhenie_double);
usilennoe_izobrazhenie = uint8(usilennoe_izobrazhenie);
figure;
imshow(usilennoe_izobrazhenie); title('Усиленное изображение после свертки');
figure;
subplot(1,2,1); imshow(seroe_izobrazhenie); title('Исходное изображение в оттенках серого');
subplot(1,2,2); imshow(usilennoe_izobrazhenie); title('Усиленное изображение после свертки');
mse = immse(seroe_izobrazhenie, usilennoe_izobrazhenie);
psnr = 10 * log10(255^2 / mse);
fprintf('Среднеквадратичная ошибка (MSE): 
fprintf('Соотношение сигнал/шум (PSNR): 
raznost_izobrazhenij = double(seroe_izobrazhenie) - double(usilennoe_izobrazhenie);
figure; imshow(mat2gray(abs(raznost_izobrazhenij))); title('Разность между исходным и усиленным изображениями');
figure; histogram(raznost_izobrazhenij, 'Normalization', 'pdf');
title('Гистограмма разности между исходным и усиленным изображениями');
xlabel('Значение разности');
ylabel('Вероятность');
figure;
subplot(1,2,1); imhist(seroe_izobrazhenie); title('Гистограмма исходного изображения');
subplot(1,2,2); imhist(usilennoe_izobrazhenie); title('Гистограмма усиленного изображения');