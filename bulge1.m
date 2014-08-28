
function targetimg = bulge1(img,amt)

% size of image
[Nrows, Ncolumns, Nchannels] = size(img);

% center of region to bulge
%xc = regionbbox(1,1)+regionbbox(1,3)/2;
%yc = regionbbox(1,2)+regionbbox(1,4)/2;
yc = Nrows/2; xc = Ncolumns/2;

% coordinates of source pixels 
[xsource,ysource] = meshgrid(1:Ncolumns, 1:Nrows);

% find polar coordinates of these pixels
r = sqrt( (xsource-xc).^2+ (ysource-yc).^2);

theta = atan2(ysource-yc, xsource-xc);

% bulge coefficient
b = 2; c = .6; d = 1/(5.*amt);

% smooth cutoff
s = 1./(1+exp( b*(c-d*r) ));

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
