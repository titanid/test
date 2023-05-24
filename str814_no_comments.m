izobrazhenie = imread('tomo.jpg');
izobrazhenie_gray = izobrazhenie;
izobrazhenie_norm = double(izobrazhenie_gray) / 255;
[grad_x, grad_y] = gradient(izobrazhenie_norm);
magnituda = sqrt(grad_x.^2 + grad_y.^2);
napravlenie = atan2(grad_y, grad_x);
porog = 0.3;
binarizovannoe_izobrazhenie = imbinarize(magnituda, porog);
razryvy_yarkosti = edge(izobrazhenie_gray, 'canny');
tochki = detectHarrisFeatures(izobrazhenie_gray);
figure;
subplot(2,2,1);
imshow(izobrazhenie);
title('Оригинальное изображение');
subplot(2,2,2);
imshow(binarizovannoe_izobrazhenie);
title('Бинаризованное изображение');
subplot(2,2,3);
imshow(razryvy_yarkosti);
title('Обнаруженные разрывы яркости');
subplot(2,2,4);
imshow(izobrazhenie);
hold on;
plot(tochki.selectStrongest(50));
title('Обнаруженные точки Харриса');