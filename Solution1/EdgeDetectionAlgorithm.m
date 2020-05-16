clear all;
close all;
clc; clf; 
  
filtreOlcusu = 5;
sigma = 14;
dusukEsikDegeri = 0.1;
yuksekEsikDegeri = 0.3;
 
image = rgb2gray(imread('armutlu.jpg'));
image = double(image); 
 
figure(1), imshow(image, []), title('Orjinal Image');
 
gaussian_filtreleme = fspecial('gaussian', filtreOlcusu, sigma);
convulationImage = conv2(image, gaussian_filtreleme, 'same'); 
 
figure (2), imshow(convulationImage, []), title(['Gaussian Filterleme sonucu \sigma = ', num2str(sigma)]);
  
[gaussian_filtreleme_x gaussian_filtreleme_y] = gradient(gaussian_filtreleme); 
image_gradient_x = conv2(convulationImage, gaussian_filtreleme_x, 'same');
image_gradient_y = conv2(convulationImage, gaussian_filtreleme_y, 'same');
normalYon = atan2(image_gradient_y, image_gradient_x);
normalYon = normalYon*180/pi;
normalYon_dis = zeros(512, 512);
for i = 1  : 512
    for j = 1 : 512 
        if ((normalYon(i, j) > 0 ) && (normalYon(i, j) < 22.5) || (normalYon(i, j) > 157.5) && (normalYon(i, j) < -157.5))
            normalYon_dis(i, j) = 0;
        end        
        if ((normalYon(i, j) > 22.5) && (normalYon(i, j) < 67.5) || (normalYon(i, j) < -112.5) && (normalYon(i, j) > -157.5))
            normalYon_dis(i, j) = 45;
        end        
        if ((normalYon(i, j) > 67.5 && normalYon(i, j) < 112.5) || (normalYon(i, j) < -67.5 && normalYon(i, j) > 112.5))
            normalYon_dis(i, j) = 90;
        end        
        if ((normalYon(i, j) > 112.5 && normalYon(i, j) <= 157.5) || (normalYon(i, j) < -22.5 && normalYon(i, j) > -67.5))
            normalYon_dis(i, j) = 135;
        end
    end
end
 
figure(3), imshow(image_gradient_x), title('X Gradyan');
 
figure(4), imshow(image_gradient_y), title('Y Gradyan');
 
figure(5), imagesc(normalYon_dis); colorbar, title('Normal Yon');
 
imageGradientMagnitude = sqrt(image_gradient_x.^2 + image_gradient_y.^2);
 
figure(6), imshow(imageGradientMagnitude, []), title('Gradyan Buyuklugu');

imageSupressed = zeros(512, 512);
for i = 2  : 511
    for j = 2 : 511        
        if (normalYon_dis(i, j) == 0)
            if (imageGradientMagnitude(i, j) > imageGradientMagnitude(i, j - 1) && imageGradientMagnitude(i, j) > imageGradientMagnitude(i, j + 1))
                imageSupressed(i, j) = imageGradientMagnitude(i, j);
            else
                imageSupressed(i, j) = 0;
            end
        end 
        if (normalYon_dis(i, j) == 45)
            if (imageGradientMagnitude(i, j) > imageGradientMagnitude(i + 1, j - 1) && imageGradientMagnitude(i, j) > imageGradientMagnitude(i - 1, j + 1))
                imageSupressed(i, j) = imageGradientMagnitude(i, j);
            else
                imageSupressed(i, j) = 0;
            end
        end 
        if (normalYon_dis(i, j) == 90)
            if (imageGradientMagnitude(i, j) > imageGradientMagnitude(i - 1, j) && imageGradientMagnitude(i, j) > imageGradientMagnitude(i + 1, j))
                imageSupressed(i, j) = imageGradientMagnitude(i, j);
            else
                imageSupressed(i, j) = 0;
            end
        end 
        if (normalYon_dis(i, j) == 135)
            if (imageGradientMagnitude(i, j) > imageGradientMagnitude(i - 1, j - 1) && imageGradientMagnitude(i, j) > imageGradientMagnitude(i + 1, j + 1))
                imageSupressed(i, j) = imageGradientMagnitude(i, j);
            else
                imageSupressed(i, j) = 0;
            end
        end 
    end
end
  
figure(7), imshow(imageSupressed), title('Image Non-Maximal Suppression');

thersholdDusukDegeri = dusukEsikDegeri * max(max(imageSupressed));
thersholdYuksekDegeri = yuksekEsikDegeri * max(max(imageSupressed));
imageThreshold = zeros(512, 512);
for i = 1  : 512
    for j = 1 : 512
        if (imageSupressed(i, j) < thersholdDusukDegeri)
            imageThreshold(i, j) = 0;
        elseif (imageSupressed(i, j) > thersholdYuksekDegeri)
            imageThreshold(i, j) = 1;
        else
            if ((imageSupressed(i + 1, j) > thersholdYuksekDegeri) || (imageSupressed(i - 1, j) > thersholdYuksekDegeri) || (imageSupressed(i, j + 1) > thersholdYuksekDegeri) || (imageSupressed(i, j - 1) > thersholdYuksekDegeri))
                imageThreshold(i, j) = 1;
            end
        end
    end
end 
figure(8),imshow(imageThreshold),title('Hysteresis Thresholding');

