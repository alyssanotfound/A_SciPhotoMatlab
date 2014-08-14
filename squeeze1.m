
function targetimg = squeeze1(img,regionbbox)

% size of image
[Nrows, Ncolumns, Nchannels] = size(img);

% center of image
xc = regionbbox(1,1)+regionbbox(1,3)/2;
yc = regionbbox(1,2)+regionbbox(1,4)/2;

% coordinates of source pixels
[xsource,ysource] = meshgrid(1:Ncolumns, 1:Nrows);

% find polar coordinates of these pixels
r = sqrt( (xsource-xc).^2+ (ysource-yc).^2);
rmax = max(max(r));
rmax = rmax/2;
theta = atan2(ysource-yc, xsource-xc);

% squeeze coefficients
a = 0.8; b = 1./1.5;
rtilde = rmax*a*((r/rmax).^b);

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
set(gcf, 'Color', [1,1,1]);
%subplot(1,2,1); image(img);       axis equal; title('Original', 'FontSize', 18);
imshow(targetimg); axis equal off; 
 
