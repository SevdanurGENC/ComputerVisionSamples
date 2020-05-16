clc;
clear all;
close all; 

image = imread('oda.jpg');
image_gray = rgb2gray(image);
image_histogram = histeq(image_gray);
image_adapthisteq = adapthisteq(image_gray);

subplot(2,4,1), imshow(image), title('orjinal imaj'); 
subplot(2,4,3), imshow(image_gray), title('imaj gray'); 
subplot(2,4,4), imhist(image_gray);,title('imaj gray - histogram');
subplot(2,4,5), imshow(image_histogram), title('esitlenmis'); 
subplot(2,4,6), imhist(image_histogram);,title('esitlenmis - histogram');
subplot(2,4,7), imshow(image_adapthisteq), title('kontrast sinirli'); 
subplot(2,4,8), imhist(image_adapthisteq);,title('kontrast sinirli - histogram');
