set(gcf, 'Color', [1,1,1]);

surf(peaks)
axis vis3d
t = 0:pi/20:2*pi;
dx = sin(t)./40;
dy = t./1000;
dz = t./1000;
camzoom(4);
axis off;
for i = 1:length(t);
    camdolly(dx(i),dy(i),dz(i))
    drawnow
end