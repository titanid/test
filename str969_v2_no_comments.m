imyaFayla = 'tomo.jpg'; 
A = imread(imyaFayla);
if size(A, 3) == 3
    A = rgb2gray(A);
end
A = im2double(A);
porog = 0.5;
binar = imbinarize(A, porog);
[Gx, Gy] = imgradientxy(binar, 'Sobel');
G = sqrt(Gx.^2 + Gy.^2);
oblast = imfill(G, 'holes');
[oblastY, oblastX] = find(oblast);
oblastVektor = [oblastX, oblastY];
sredneeOblast =mean(oblastVektor);
kovMatOblast = cov(oblastVektor);
[V, D] = eig(kovMatOblast);
tsentr = sredneeOblast;
konec1 = tsentr + V(:,1)' * 50; 
nachalo1 = tsentr - V(:,1)' * 50;
konec2 = tsentr + V(:,2)' * 50;
nachalo2 = tsentr - V(:,2)' * 50;
figure;
subplot(1, 2, 1);
imshow(A);
title('Исходное изображение');
subplot(1, 2, 2);
imshow(oblast);
hold on;
plot(tsentr(1), tsentr(2), 'r+', 'MarkerSize', 10);
plot([nachalo1(1), konec1(1)], [nachalo1(2), konec1(2)], 'r-', 'LineWidth', 2);
plot([nachalo2(1), konec2(1)], [nachalo2(2), konec2(2)], 'g-', 'LineWidth', 2);
title('Область объекта с направлениями главных компонент');
rezultat.binar = binar;
rezultat.oblast = oblast;
rezultat.sredneeOblast = sredneeOblast;
rezultat.kovMatOblast = kovMatOblast;
rezultat.napravlenie1 = V(:,1);
rezultat.napravlenie2 = V(:,2);