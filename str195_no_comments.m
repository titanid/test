imya_fayla = 'tomo.jpg'; 
vhodnaya_kartinka = imread(imya_fayla);
vhodnaya_kartinka_gray = vhodnaya_kartinka;
[chastota_yarkosti, uroven_yarkosti] = imhist(vhodnaya_kartinka_gray);
vyrovnenie_gistogrammy = histeq(vhodnaya_kartinka_gray);
[chastota_yarkosti_vykh, uroven_yarkosti_vykh] = imhist(vyrovnenie_gistogrammy);
vykhodnaya_kartinka = vyrovnenie_gistogrammy;
imwrite(vykhodnaya_kartinka, 'обработанная_картинка.jpg');
figure;
subplot(2, 2, 1);
imshow(vhodnaya_kartinka);
title('Входное изображение');
subplot(2, 2, 2);
imshow(vykhodnaya_kartinka);
title('Выходное изображение');
subplot(2, 2, 3);
bar(uroven_yarkosti, chastota_yarkosti);
xlabel('Уровень яркости');
ylabel('Частота');
title('Гистограмма входного изображения');
subplot(2, 2, 4);
bar(uroven_yarkosti_vykh, chastota_yarkosti_vykh);
xlabel('Уровень яркости');
ylabel('Частота');
title('Гистограмма выходного изображения');