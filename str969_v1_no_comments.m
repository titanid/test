A = imread('tomo.jpg');
rezultat = analyze_image(A);
function rezultat = analyze_image(A)
razmer = size(A);
porog = 0.5;
binar = imbinarize(A, porog);
[Gx, Gy] = imgradientxy(binar, 'Sobel');
G = sqrt(Gx.^2 + Gy.^2);
oblast = imfill(G, 'holes');
granitsa = G > 0;
[oblastY, oblastX] = find(oblast);
[granitsaY, granitsaX] = find(granitsa);
oblastVektor = [oblastX, oblastY];
granitsaVektor = [granitsaX, granitsaY];
sredneeOblast = mean(oblastVektor);
kovMatOblast = cov(oblastVektor);
sredneeGranitsa = mean(granitsaVektor);
kovMatGranitsa = cov(granitsaVektor);
figure;
subplot(2, 2, 1);
imshow(A);
title('Оригинальное изображение');
subplot(2, 2, 2);
imshow(binar);
title('Бинаризованное изображение');
subplot(2, 2, 3);
imshow(oblast);
hold on;
plot(sredneeOblast(1), sredneeOblast(2), 'r+', 'MarkerSize', 10);
title('Область объекта с центром масс');
subplot(2, 2, 4);
imshow(granitsa);
hold on;
plot(sredneeGranitsa(1), sredneeGranitsa(2), 'r+', 'MarkerSize', 10);
title('Граница объекта с центром масс');
rezultat.binar = binar;
rezultat.oblast = oblast;
rezultat.granitsa = granitsa;
rezultat.sredneeOblast = sredneeOblast;
rezultat.kovMatOblast = kovMatOblast;
rezultat.sredneeGranitsa = sredneeGranitsa;
rezultat.kovMatGranitsa = kovMatGranitsa;
end