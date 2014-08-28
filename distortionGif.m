clc; clear all; close all;
noseDetector = vision.CascadeObjectDetector('Nose');
eyesDetector = vision.CascadeObjectDetector('EyePairSmall');

img = imread('beyonce.png');

nosebbox = step(noseDetector,img);
eyesbbox = step(eyesDetector,img);
%make left and right eye boxes out of pair eye box
neweyewidth = eyesbbox(1,3)/2;
leyebbox = eyesbbox;
leyebbox(1,3) = neweyewidth;
reyebbox = leyebbox;
reyebbox(1,1) =reyebbox(1,1) + neweyewidth;

set(gcf, 'Color', [1,1,1]);
filename = 'testnew3.gif';


      
for n = 1.0:0.5:4.0
      
      stitchedimg = img;
      ax = 0;
      ay = 120;
      [croppedimg,nx,ny,enx,eny] = cropf(img,reyebbox,ax,ay);
      [newimg] = bulge1(croppedimg,n);
      [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);
      
      ax = 0;
      ay = 30;
      [croppedimg,nx,ny,enx,eny] = cropf(img,leyebbox,ax,ay);
      [newimg] = squeeze1(croppedimg,n);
      [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);
      
      ax = 0;
      ay = 0;
      %[croppedimg,nx,ny,enx,eny] = cropf(img,nosebbox,ax,ay);
      %[newimg] = squeeze1(croppedimg,n);
      %[stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);
      
      imshow(stitchedimg); axis equal off;
    
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 1.0;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end