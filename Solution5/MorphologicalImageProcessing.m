clc;
clear all;
close all;
 
image = imread('kompozit.tif');
figure, imshow(image), title('orjinal imaj');
 
imageBackground = 255 - image;
figure, imshow(imageBackground), title('imajin arka plani');
 
se = strel('disk', 20);
erode = imerode(imageBackground, se);
figure, imshow(erode), title('imajin asindirilmis hali');
 
dilate = imdilate(imageBackground, se);
figure, imshow(dilate), title('imajin genisletilmis hali');
 
opening = imopen(imageBackground, se);
figure, imshow(opening), title('imajin acilmis hali');
 
closing = imclose(imageBackground, se);
figure, imshow(closing), title('imajin kapanmis hali');
 
subplot(331), imshow(image), title('orjinal imaj');
subplot(332), imshow(imageBackground), title('imajin arka plani');
subplot(333), imshow(erode), title('imajin asindirilmis hali');
subplot(334), imshow(dilate), title('imajin genisletilmis hali');
subplot(335), imshow(opening), title('imajin acilmis hali');
subplot(336), imshow(closing), title('imajin kapanmis hali');
