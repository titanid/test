im = imread('tomo.jpg');
im_gray = im;
im_gray = im2double(im_gray);
[Gx, Gy] = gradient(im_gray);
Lap = del2(im_gray);
porog = 0.02;
perepady = abs(Lap) > porog;
rezultat = perepady;
figure;
subplot(2, 2, 1);
imshow(im_gray);
title('Исходное изображение');
subplot(2, 2, 2);
imshow(Gx, []);
title('Градиент по X');
subplot(2, 2, 3);
imshow(Gy, []);
title('Градиент по Y');
subplot(2, 2, 4);
imshow(rezultat);
title('Результат сегментации');