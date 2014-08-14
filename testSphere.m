clc; clear all; close all;
imgRGB = imread('beyonceCrop.png');
figure(1)

k = 7;
n = 2^k-1;

theta = pi*(-n:2:n)/n;
phi = (pi/2)*(-n:2:n)'/n;

set(gcf, 'Color', [1,1,1]);
filename = 'sphere.gif';

X = cos(phi)*cos(theta);
Y = cos(phi)*sin(theta);
Z = sin(phi)*ones(size(theta));

for n = 1:1:36
    
      h = surf(X,Y,Z,flipdim(imgRGB,1),... 
         'FaceColor','texturemap',...
         'EdgeColor','none');
      view(10*n,15);
      %camzoom(2);
      axis off;
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end