nazvanie_izobrazheniya = 'tomo.jpg';
I = imread(nazvanie_izobrazheniya);
I_gray = I;
kontrastnyi_diapazon = stretchlim(I_gray, [0.02 0.9]);
I_adjusted = imadjust(I_gray, kontrastnyi_diapazon, []);
vykhodnye_dannye = I_adjusted;
figure;
subplot(1, 2, 1);
imshow(I_gray);
title('Исходное изображение');
subplot(1, 2, 2);
imshow(vykhodnye_dannye);
title('Коррекция контраста');
figure;
subplot(1, 2, 1);
imhist(I_gray);
title('Гистограмма исходного изображения');
subplot(1, 2, 2);
imhist(vykhodnye_dannye);
title('Гистограмма обработанного изображения');