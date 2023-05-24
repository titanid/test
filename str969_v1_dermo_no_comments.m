izobrazhenie = imread('tomo.jpg'); 
gray_izobrazhenie = izobrazhenie;
bin_izobrazhenie = imbinarize(gray_izobrazhenie);
porog = [0.01, 0.02]; 
granitsy = edge(bin_izobrazhenie, 'Canny', porog);
[contury, ~] = bwboundaries(granitsy, 'noholes');
vektory_granits = cell(length(contury), 1);
for i = 1:length(contury)
    vektory_granits{i} = [contury{i}(:, 2), contury{i}(:, 1)];
end
glavnye_komponenty = cell(length(contury), 1);
for i = 1:length(contury)
    [koef, score] = pca(vektory_granits{i});
    if size(score, 2) >= 2
        glavnye_komponenty{i} = score(:, 1:2);
    else
        glavnye_komponenty{i} = score(:, 1);
    end
end
vykhodnye_dannye = glavnye_komponenty;
figure;
subplot(1, 2, 1);
imshow(izobrazhenie);
title('Исходное изображение');
subplot(1, 2, 2);
imshow(granitsy);
title('Границы изображения');
hold on;
for i = 1:length(contury)
    if size(glavnye_komponenty{i}, 2) >= 2
        plot(glavnye_komponenty{i}(:, 1), glavnye_komponenty{i}(:, 2), 'r', 'LineWidth', 2);
    else
        plot(glavnye_komponenty{i}(:, 1), glavnye_komponenty{i}(:, 1), 'r', 'LineWidth', 2);
end
end
title('Главные компоненты границы');
hold off;