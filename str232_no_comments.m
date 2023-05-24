put_k_izobrazheniyu = 'tomo.jpg'; 
izobrazhenie = imread(put_k_izobrazheniyu);
izobrazhenie_serye_tona = izobrazhenie;
[visota, shirina] = size(izobrazhenie_serye_tona);
sobel_gorizontal = fspecial('sobel');
sobel_vertikal = sobel_gorizontal';
grad_x = imfilter(double(izobrazhenie_serye_tona), sobel_gorizontal);
grad_y = imfilter(double(izobrazhenie_serye_tona), sobel_vertikal);
amplituda_gradienta = sqrt(grad_x.^2 + grad_y.^2);
norm_amplituda_gradienta = amplituda_gradienta / max(amplituda_gradienta(:));
porog = 0.1;
binarnoe_izobrazhenie = imbinarize(norm_amplituda_gradienta, porog);
kontury_izobrazheniya = binarnoe_izobrazhenie;
figure;
subplot(2, 2, 1);
imshow(izobrazhenie);
title('Оригинальное изображение');
subplot(2, 2, 2);
imshow(izobrazhenie_serye_tona);
title('Изображение в оттенках серого');
subplot(2, 2, 3);
imshow(norm_amplituda_gradienta);
title('Нормализованная амплитуда градиента');
subplot(2, 2, 4);
imshow(kontury_izobrazheniya);
title('Градиентное выделение контуров');