clc;
clear all;
close all; 

image = imread('armutlu.jpg');
image_gray = rgb2gray(image);
imageRobert = edge(image_gray,'roberts');
imagePrewitt = edge(image_gray,'prewitt');
imageSobel = edge(image_gray, 'sobel');
imageLog = edge(image_gray, 'Log');
imageCanny = edge(image_gray, 'Canny');

subplot(2,4,1), imshow(image), title('Image - Orjinal');
subplot(2,4,3), imshow(image_gray),title('Image - Gray'); 
subplot(2,4,4), imshow(imageRobert),title('Image - Robert');
subplot(2,4,5), imshow(imagePrewitt),title('Image - Prewitt');
subplot(2,4,6), imshow(imageSobel),title('Image - Sobel');
subplot(2,4,7), imshow(imageLog),title('Image - Log');
subplot(2,4,8), imshow(imageCanny),title('Image - Canny');
 