im = imread('tomo.jpg');
im_gray = im;
histogramma = imhist(im_gray);
normalizovannaya_histogramma = histogramma / numel(im_gray);
krai = edge(im_gray, 'Canny', [0.001 0.002]); 
srednee_znachenie = mean2(im_gray);
medianna = median(double(im_gray(:)));
otklonenie = std2(im_gray);
assimetriya = skewness(double(im_gray(:)));
eksczess = kurtosis(double(im_gray(:))) - 3;
kolichestvo_konturov = sum(krai(:));
konturnaya_ploshad = bwarea(krai);
rezultaty_gistogrammy = struct('histogramma', normalizovannaya_histogramma, 'srednee_znachenie', srednee_znachenie, 'medianna', medianna, 'otklonenie', otklonenie, 'assimetriya', assimetriya, 'eksczess', eksczess);
rezultaty_konturov = struct('kolichestvo_konturov', kolichestvo_konturov, 'konturnaya_ploshad', konturnaya_ploshad);
figure;
subplot(2, 2, 1);
imshow(im);
title('Оригинальное изображение');
subplot(2, 2, 2);
imshow(im_gray);
title('Оттенки серого');
subplot(2, 2, 3);
bar(normalizovannaya_histogramma);
title('Нормализованная гистограмма');
xlabel('Уровни яркости');
ylabel('Частота');
subplot(2, 2, 4);
imshow(krai);
title('Контуры изображения');