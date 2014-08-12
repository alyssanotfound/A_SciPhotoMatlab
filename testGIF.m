x = 0:0.01:1;
imgRGB = imread('beyonce.png');
figure(1)
[x,y]=meshgrid(1:15,1:15);
tri = delaunay(x,y);
z1 = peaks(15);
set(gcf, 'Color', [1,1,1]);
filename = 'testnew.gif';
for n = 1:0.2:5
      z2 = z1.*randn;
    
      h = surf(x,y,z2,flipdim(imgRGB,1),... 
         'FaceColor','texturemap',...
         'EdgeColor','none');
      axis([0 15 0 15 -15 15]);
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