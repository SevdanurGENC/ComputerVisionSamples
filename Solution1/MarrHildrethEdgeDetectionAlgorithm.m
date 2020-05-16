close all;
clear all;
clc;

image = rgb2gray(imread('armutlu.jpg'));

marrHildreth1 = edge(image,'log',0,1.0);
marrHildreth2 = edge(image,'log',0,2.0);
marrHildreth3 = edge(image,'log',0,3.0);
marrHildreth4 = edge(image,'log',0,4.0);
 
goruntu1 = [ marrHildreth1 marrHildreth2; marrHildreth3 marrHildreth4];
 
log = figure('Name','Marr/Hildreth: UL: s=1  UR: s=2  BL: s=3 BR: s=4');
iptsetpref('ImshowBorder','tight');
imshow(goruntu1,'InitialMagnification',100);
 
[Canny1, CannytDetection1] = edge(image,'canny',[],1.0);
[Canny2, CannytDetection2] = edge(image,'canny',[],2.0);
[Canny3, CannytDetection3] = edge(image,'canny',[],3.0);
[Canny4, CannytDetection4] = edge(image,'canny',[],4.0);
 
k = 0.75
Canny1 = edge(image,'canny',k*CannytDetection1,1.0);
Canny2 = edge(image,'canny',k*CannytDetection2,2.0);
Canny3 = edge(image,'canny',k*CannytDetection3,3.0);
Canny4 = edge(image,'canny',k*CannytDetection4,4.0);
 
goruntu2 = [ Canny1 Canny2; Canny3 Canny4 ];
 
canny = figure('Name','Canny: UL: s=1  UR: s=2  BL: s=3 BR: s=4');
iptsetpref('ImshowBorder','tight');
imshow(goruntu2,'InitialMagnification',100); 