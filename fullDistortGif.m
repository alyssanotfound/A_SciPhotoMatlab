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

for n = 0.2:0.1:0.9
      
      [img] = bulgeO(img,reyebbox,n);
      %[newimg] = bulgeO(img,leyebbox,n);
      %[newimg] = squeeze1(newimg,nosebbox,n);

      imshow(img); axis equal off;  
    
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 0.5;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end