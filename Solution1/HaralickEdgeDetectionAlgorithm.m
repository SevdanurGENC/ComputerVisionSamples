function [Edges]=haralickKenarTespitYontemi(image, esikDegeri)
close all;
clear all;
clc;
    image=imread('armutlu.jpg'); 
    esikDegeri=0.5;  
    image = double(rgb2gray(image)); 
    image = double(image); 

imageGaussian = fspecial('gaussian', 15, 2.5);
imageGaussianFiltreleme=imfilter(double(image), imageGaussian, 'replicate','conv');

Maske=maskeOlustur();
imageMaske=cell(10);

for i=2:10
    imageMaske{i}=zeros(size(image));
    imageMaske{i}=imfilter(double(imageGaussianFiltreleme), Maske{i}, 'replicate','conv');
end
 
Maske2=imageMaske{2};
Maske3=imageMaske{3};
Maske4=imageMaske{4};
Maske5=imageMaske{5};
Maske6=imageMaske{6};
Maske7=imageMaske{7};
Maske8=imageMaske{8};
Maske9=imageMaske{9};
Maske10=imageMaske{10};
 
KNormInv=1.0./(sqrt(Maske2.*Maske2+Maske3.*Maske3)+eps);
sinTheta=Maske2.*KNormInv;
cosTheta=Maske3.*KNormInv;
 
C2=Maske4.*sinTheta.*sinTheta+Maske5.*sinTheta.*cosTheta+Maske6.*cosTheta.*cosTheta;
C3=Maske7.*sinTheta.*sinTheta.*sinTheta+Maske8.*sinTheta.*sinTheta.*cosTheta+Maske9.*sinTheta.*cosTheta.*cosTheta+Maske10.*cosTheta.*cosTheta.*cosTheta;

ind=find(C3<0 & abs(C2./(3*C3))<esikDegeri);  
 
Edges=zeros(size(image));
Edges(ind)=255;
figure,subplot(1,2,1), imshow(uint8(image),[]);
subplot(1,2,2), imshow(uint8(Edges),[]);
end
 
function [Maske]=maskeOlustur()
Maske=cell(10);
Maske{1}=(1/175)*[-13 2 7 2 -13; 2 17 22 17 2 ; 7 22 27 22 7;2 17 22 17 2 ; -13 2 7 2 -13];
Maske{2}=(1/420)*[31 -5 17 -5 31; -44 -62 -68 -62 -44; 0 0 0 0 0; 44 62 68 62 44 ; -31 5 17 5 -31];
Maske{3}=Maske{2}';
Maske{4}=(1/70)*[2 2 2 2 2; -1 -1 -1 -1 -1; -2 -2 -2 -2 -2; -1 -1 -1 -1 -1; 2 2 2 2 2];
Maske{5}=(1/100)*[4 2 0 -2 -4; 2 1 0 -1 -2; 0 0 0 0 0; -2 -1 0 1 2; -4 -2 0 2 4];
Maske{6}=Maske{4}';
Maske{7}=(1/60)*[-1 -1 -1 -1 -1; 2 2 2 2 2; 0 0 0 0 0; -2 -2 -2 -2 -2; 1 1 1 1 1];
Maske{8}=(1/140)*[-4 -2 0 2 4; 2 1 0 -1 -2; 4 2 0 -2 -4; 2 1 0 -1 -2; -4 -2 0 2 4];
Maske{9}=Maske{8}';
Maske{10}=Maske{7}';
end