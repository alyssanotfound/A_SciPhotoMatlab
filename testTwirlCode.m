clc; clear all; close all;
img = imread('bey2.jpg');
[Nrows, Ncolumns, Nchannels] = size(img);
yc = Nrows/2; xc = Ncolumns/2;
[xsource,ysource] = meshgrid(1:Ncolumns, 1:Nrows);
r = sqrt( (xsource-xc).^2+ (ysource-yc).^2);
theta = atan2(ysource-yc, xsource-xc);
a = 1.5; b = 10; c = 0.6; d = 1/150;
s = 1./(1+exp(b*(c-d*r)));
% modified theta
thetatilde = theta + (1.0 - s)*a;

% back out Cartesian coordinates
xtilde = r.*cos(thetatilde) + xc;
ytilde = r.*sin(thetatilde) + yc;

% target image
targetimg = uint8(zeros(Nrows, Ncolumns, Nchannels));

dimg = double(img);
targetimg(:,:,1) = interp2(xsource, ysource, dimg(:,:,1), xtilde, ytilde, 'spline');
targetimg(:,:,2) = interp2(xsource, ysource, dimg(:,:,2), xtilde, ytilde, 'spline');
targetimg(:,:,3) = interp2(xsource, ysource, dimg(:,:,3), xtilde, ytilde, 'spline');
targetimg = uint8(targetimg);

% plot before and after
set(gcf, 'Color', [1,1,1]);
subplot(1,2,1); image(img);          axis equal off; title('Original', 'FontSize', 18);
subplot(1,2,2); image(targetimg); axis equal off; title('Mapped',   'FontSize', 18);
 
