
function targetimg = squeeze1(img)

% size of image
[Nrows, Ncolumns, Nchannels] = size(img);

% center of image
yc = Nrows/2; xc = Ncolumns/2;

% coordinates of source pixels
[xsource,ysource] = meshgrid(1:Ncolumns, 1:Nrows);

% find polar coordinates of these pixels
r = sqrt( (xsource-xc).^2+ (ysource-yc).^2);
rmax = max(max(r));
theta = atan2(ysource-yc, xsource-xc);

% squeeze coefficients
a = 1; b = 1./(1);
rtilde = (rmax*a*((r/rmax).^b));

% back out Cartesian coordinates
xtilde = rtilde.*cos(theta) + xc;
ytilde = rtilde.*sin(theta) + yc;

% target image
targetimg = zeros(Nrows, Ncolumns, Nchannels);

%% Use built in MATLAB interpolation
dimg = double(img);
targetimg(:,:,1) = interp2(xsource, ysource, dimg(:,:,1), xtilde, ytilde);
targetimg(:,:,2) = interp2(xsource, ysource, dimg(:,:,2), xtilde, ytilde);
targetimg(:,:,3) = interp2(xsource, ysource, dimg(:,:,3), xtilde, ytilde);
targetimg = uint8(targetimg);

% plot before and after
subplot(1,3,1); image(img);       axis equal; title('Original', 'FontSize', 18);
subplot(1,3,2); image(targetimg); axis equal; title('Squeezed', 'FontSize', 18);

% plot the radial change
r = linspace(0, 500, 500);
rmax = max(max(r));
rtilde = rmax*a*((r/rmax).^b);
rshift = rtilde-r;
subplot(1,3,3); plot(r, rshift, 'r-'); 
xlabel('r', 'FontSize', 18); ylabel('r~ - r', 'FontSize', 18);
title('Radial squeeze', 'FontSize', 18); 
