function targetimgf = bulge1(img,regionbbox,amt)

addx = 50;
addy = 100;

regionbbox(:,1) = int16(regionbbox(:,1) -(addx/2));
regionbbox(:,2) = int16(regionbbox(:,2) -(addy/2));
regionbbox(:,3) = int16(regionbbox(:,3) +addx);
regionbbox(:,4) = int16(regionbbox(:,4) +addy);

nx = regionbbox(:,1);
ny = regionbbox(:,2);
enx = regionbbox(:,1) + regionbbox(:,3);
eny = regionbbox(:,2) + regionbbox(:,4);

img2 = imcrop(img,regionbbox);

% size of image
[Nrows, Ncolumns, Nchannels] = size(img2)

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
b = 5*amt; c = 0.4; d = 1/100;

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
dimg = double(img2);
targetimg(:,:,1) = interp2(xsource, ysource, dimg(:,:,1), xtilde, ytilde);
targetimg(:,:,2) = interp2(xsource, ysource, dimg(:,:,2), xtilde, ytilde);
targetimg(:,:,3) = interp2(xsource, ysource, dimg(:,:,3), xtilde, ytilde);
targetimg = uint8(targetimg);

targetimgf = img;

size(targetimg(:,:,1))
size(targetimg(:,:,2))
size(targetimg(:,:,3))

targetimgf(ny:eny,nx:enx,1) = targetimg(:,:,1);
targetimgf(ny:eny,nx:enx,2) = targetimg(:,:,2);
targetimgf(ny:eny,nx:enx,3) = targetimg(:,:,3);
