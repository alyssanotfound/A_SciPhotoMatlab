clc; clear all; close all;

imgRGB = imread('beyonce.png');

figure
[x,y]=meshgrid(1:15,1:15);
tri = delaunay(x,y);
z1 = peaks(15);
h = surf(x,y,z1,flipdim(imgRGB,1),... 
         'FaceColor','texturemap',...
         'EdgeColor','none');

print -dpng figplot.png
