
function targetimg = bulge1(img,regionbbox)

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
theta = atan2(ysource-yc, xsource-xc);

% bulge coefficient
b = 2; c = 0.4; d = 1/100;

% smooth cutoff
s = 1./(1+exp(b*(c-d*r)));

% bulge coefficients
rtilde = r.*s;

% back out Cartesian coordinates
xtilde = rtilde.*cos(theta) + xc;
ytilde = rtilde.*sin(theta) + yc;

% target image
targetimg = uint8(zeros(Nrows, Ncolumns, Nchannels));

%% Use built in MATLAB interpolation
dimg = double(img);
targetimg(:,:,1) = interp2(xsource, ysource, dimg(:,:,1), xtilde, ytilde);
targetimg(:,:,2) = interp2(xsource, ysource, dimg(:,:,2), xtilde, ytilde);
targetimg(:,:,3) = interp2(xsource, ysource, dimg(:,:,3), xtilde, ytilde);
targetimg = uint8(targetimg);

% plot before and after
%set(gcf, 'Color', [1,1,1]);
%subplot(1,2,1); image(img);       axis equal off; title('Original', 'FontSize', 18);
%imshow(targetimg); axis equal off; hold on; 

