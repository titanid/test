imya_fayla = 'tomo.jpg'; 
kartinka = imread(imya_fayla);
kartinka_gray = kartinka;
korrelatsionnaya_funktsiya = xcorr2(double(kartinka_gray));
spetr = fftshift(fft2(korrelatsionnaya_funktsiya));
razmer_okna = 36; 
usredneniye_lokalnykh_spektr = filter2(ones(razmer_okna)/razmer_okna^2, abs(spetr));
maska = fspecial('gaussian', razmer_okna, 2); 
maskirovaniye = filter2(maska, usredneniye_lokalnykh_spektr);
sglazhivaniye_spektra = filter2(ones(razmer_okna)/razmer_okna^2, abs(spetr));
rezultaty.korrelatsionnaya_funktsiya = korrelatsionnaya_funktsiya;
rezultaty.spetr = spetr;
rezultaty.usredneniye_lokalnykh_spektr = usredneniye_lokalnykh_spektr;
rezultaty.maskirovaniye = maskirovaniye;
rezultaty.sglazhivaniye_spektra = sglazhivaniye_spektra;
figure;
subplot(2, 3, 1);
imshow(kartinka_gray);
title('Входное изображение');
subplot(2, 3, 2);
imshow(korrelatsionnaya_funktsiya);
title('Корреляционная функция');
subplot(2, 3, 3);
imshow(log(abs(spetr)), []);
title('Спектр');
subplot(2, 3, 4);
imshow(log(usredneniye_lokalnykh_spektr), []);
title('Усредненный локальный спектр');
subplot(2, 3, 5);
imshow(log(maskirovaniye), []);
title('Маскированный спектр');
subplot(2, 3, 6);
imshow(log(sglazhivaniye_spektra), []);
title('Сглаженный спектр');
figure;
subplot(1, 2, 1);
imshow(kartinka_gray);
title('Входное изображение');
subplot(1, 2, 2);
vosstanovlennoye = ifft2(ifftshift(sglazhivaniye_spektra));
imshow(uint8(abs(vosstanovlennoye)));
title('Восстановленное изображение');