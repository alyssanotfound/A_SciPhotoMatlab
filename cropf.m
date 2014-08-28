
function [cropregion,nx,ny,enx,eny] = cropf(img,regionbbox,addx,addy)

regionbbox(:,1) = int16(regionbbox(:,1) -(addx/2));
regionbbox(:,2) = int16(regionbbox(:,2) -(addy/2));
regionbbox(:,3) = int16(regionbbox(:,3) +addx);
regionbbox(:,4) = int16(regionbbox(:,4) +addy);

nx = regionbbox(:,1);
ny = regionbbox(:,2);
enx = regionbbox(:,1) + regionbbox(:,3);
eny = regionbbox(:,2) + regionbbox(:,4);

cropregion = imcrop(img,regionbbox);


