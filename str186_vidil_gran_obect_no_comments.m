img = imread('tomo.jpg');
if size(img, 3) == 3
    img = rgb2gray(img);
end
med_img = img;
edge_img = edge(med_img, 'Canny');
figure; imshow(edge_img); title('Изображение после выделения границ');
obj_img = imfill(edge_img, 'holes');
figure; imshow(obj_img); title('Изображение после выделения объектов');
if size(img, 3) == 3
    output_img = uint8(repmat(obj_img, [1 1 3])) * 255;
else
    output_img = uint8(obj_img) * 255;
end
figure; imshow(img); title('Исходное изображение');
figure; imshow(output_img); title('Выходное изображение');
diff_img = imabsdiff(img, output_img);
figure; imshow(diff_img); title('Разница между исходным и выходным изображениями');