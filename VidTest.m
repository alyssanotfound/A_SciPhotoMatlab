clc; clear all; close all;

imageNames = dir(fullfile('workingDir','images','*.jpg'));
imageNames = {imageNames.name}';
disp(imageNames);

outputVideo = VideoWriter(fullfile('workingDir','test_out.avi'));
%outputVideo.FrameRate = omovie.FrameRate;
open(outputVideo);

for ii = 1:length(imageNames)
    I = imread(fullfile('workingDir','images',imageNames{ii}));
    writeVideo(outputVideo,I);
end

close(outputVideo);
shuttleAvi = VideoReader(fullfile('workingDir','test_out.avi'));
mov(shuttleAvi.NumberOfFrames) = struct('cdata',[],'colormap',[]);

for ii = 1:shuttleAvi.NumberOfFrames
    mov(ii) = im2frame(read(shuttleAvi,ii));
end

set(gcf,'position', [150 150 shuttleAvi.Width shuttleAvi.Height])
set(gca,'units','pixels');
set(gca,'position',[0 0 shuttleAvi.Width shuttleAvi.Height])

image(mov(1).cdata,'Parent',gca);
axis off;

movie(mov,1,shuttleAvi.FrameRate);