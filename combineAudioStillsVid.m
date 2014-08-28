clc; clear all; close all;

%audio processing
afile = 'calle.wav';
[y,Fs]=wavread(afile);
nsamples = 10 * Fs;
[y2, Fs] = wavread(afile, nsamples);
t=0:1/Fs:(length(y2)-1)/Fs;
[pks,locs] = findpeaks(y2(:,2),'minpeakdistance',10000);
%pkSecs gives the time code when to start distortions
pkSecs = t(locs);
pkFrames = round(pkSecs/0.033333);
%disp(pkFrames);

workingDir = 'newfolder';
mkdir(workingDir);
mkdir(workingDir,'images');

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
%figure(1);
set(gcf, 'Color', [1,1,1]);
filename = 'testnew3.gif';

%for j = 1:1:length(pkFrames)
    for i = 0:1:pkFrames(1)-1
        imshow(img,'Border','tight');

        drawnow
        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,fullfile(workingDir,'images',sprintf('img%d.jpg',i)));        
    end
    for i = pkFrames(1):1:pkFrames(1)+8
        %disp(i);
        stitchedimg = img;
        ax = 0;
        ay = 30;
        [croppedimg,nx,ny,enx,eny] = cropf(img,reyebbox,ax,ay);
        [newimg] = bulge1(croppedimg,i/8);
        [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);

        ax = 0;
        ay = 30;
        [croppedimg,nx,ny,enx,eny] = cropf(img,leyebbox,ax,ay);
        [newimg] = squeeze1(croppedimg,i/8);
        [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);

        imshow(stitchedimg,'Border','tight');

        drawnow
        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,fullfile(workingDir,'images',sprintf('img%d.jpg',i)));        
    end
%end

%creating jpegs and storing in folder      
%{
for n = 2:1:8
      
      stitchedimg = img;
      ax = 0;
      ay = 120;
      [croppedimg,nx,ny,enx,eny] = cropf(img,reyebbox,ax,ay);
      [newimg] = bulge1(croppedimg,n/2);
      [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);
      
      ax = 0;
      ay = 30;
      [croppedimg,nx,ny,enx,eny] = cropf(img,leyebbox,ax,ay);
      [newimg] = squeeze1(croppedimg,n/2);
      [stitchedimg] = stitchf(stitchedimg,newimg,nx,ny,enx,eny);
      
      imshow(stitchedimg); axis equal off;
    
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      imwrite(imind,cm,fullfile(workingDir,'images',sprintf('img%d.jpg',n)));
end
%}
%ouput video from jpegs
imageNames = dir(fullfile('newfolder','images','*.jpg'));
imageNames = {imageNames.name}';
%disp(imageNames);

imageStrings = regexp([imageNames{:}],'(\d*)','match');
imageNumbers = str2double(imageStrings);

[~,sortedIndices] = sort(imageNumbers);
sortedImageNames = imageNames(sortedIndices);

%disp(sortedImageNames);


outputVideo = VideoWriter(fullfile('newfolder','test_out.avi'));
outputVideo.FrameRate = 10; %change this to 30 to match the audio
open(outputVideo);

for ii = 1:length(sortedImageNames)
    I = imread(fullfile('newfolder','images',sortedImageNames{ii}));
    writeVideo(outputVideo,I);
end

close(outputVideo);
shuttleAvi = VideoReader(fullfile('newfolder','test_out.avi'));
mov(shuttleAvi.NumberOfFrames) = struct('cdata',[],'colormap',[]);

for ii = 1:shuttleAvi.NumberOfFrames
    mov(ii) = im2frame(read(shuttleAvi,ii));
end

%set(gcf,'position', [0 0 shuttleAvi.Width shuttleAvi.Height])
set(gca,'units','pixels');
set(gca,'position',[0 0 shuttleAvi.Width shuttleAvi.Height])

image(mov(1).cdata,'Parent',gca);
axis off;

movie(mov,1,shuttleAvi.FrameRate);