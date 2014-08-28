function stitched = stitchf(stitched,distarea,nx,ny,enx,eny)

stitched(ny:eny,nx:enx,1) = distarea(:,:,1);
stitched(ny:eny,nx:enx,2) = distarea(:,:,2);
stitched(ny:eny,nx:enx,3) = distarea(:,:,3);
      
