clc;
clear all;
close all; 

image = imread('sekiller.jpg');
figure, imshow(image);
image = double(image(:,:,1));

[Fx,Fy] = gradient(image);
xspace = (1:2:size(image,2));
yspace = (1:2:size(image,2));
qx = interp2(Fx,xspace,yspace');
qy = interp2(Fy,xspace,yspace');

figure;
quiver(xspace,yspace,qx,qy);

axis image;