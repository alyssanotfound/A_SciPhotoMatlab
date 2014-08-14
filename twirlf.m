clc; clear all; close all;
noseDetector = vision.CascadeObjectDetector('Nose');
eyesDetector = vision.CascadeObjectDetector('EyePairSmall');

img = imread('bey2.jpg');

nosebbox = step(noseDetector,img);
eyesbbox = step(eyesDetector,img);
%make left and right eye boxes out of pair eye box
neweyewidth = eyesbbox(1,3)/2;
leyebbox = eyesbbox;
leyebbox(1,3) = neweyewidth;
reyebbox = leyebbox;
reyebbox(1,1) =reyebbox(1,1) + neweyewidth;

%img = insertObjectAnnotation(img,'rectangle',nosebbox,'Nose');
%img = insertObjectAnnotation(img,'rectangle',leyebbox,'L Eye');
%img = insertObjectAnnotation(img,'rectangle',reyebbox,'R Eye');

[newimg] = bulge1(img,reyebbox);
[newimg] = bulge1(newimg,leyebbox);
[newimg] = squeeze1(newimg,nosebbox);

set(gcf, 'Color', [1,1,1]);
imshow(newimg); axis equal off; hold on; 
%squeeze1(img,eyesbbox);
%squeeze1(img);