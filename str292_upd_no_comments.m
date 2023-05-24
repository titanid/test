img = imread('tomo.jpg');
img_gray = img;
edge_img = edge(img_gray, 'Canny');
fill_img = imfill(edge_img, 'holes');
label_img = bwlabel(fill_img);
props = regionprops(label_img);
imshow(img);
hold on;
for i = 1:length(props)
    rectangle('Position', props(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end
title('Обнаруженные объекты');
xlabel('Ширина, пиксели');
ylabel('Высота, пиксели');
hold off;
labels = label_img;
objects = props;
num_objects = length(props);
disp(['Обнаружено объектов: ', num2str(num_objects)]);
sizes = [props.Area];
figure;
plot(sizes, 'bo');
title('Размеры объектов');
xlabel('Номер объекта');
ylabel('Площадь, пиксели');
widths = [props.BoundingBox];
widths = widths(3:4:end);
heights = [props.BoundingBox];
heights = heights(4:4:end);
figure;
plot(widths, heights, 'ro');
title('Описывающий прямоугольник объектов');
xlabel('Ширина, пиксели');
ylabel('Высота, пиксели');
size_plot = gcf;
rect_plot = gcf;