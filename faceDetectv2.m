clc; clear all; close all;
faceDetector = vision.CascadeObjectDetector();
noseDetector = vision.CascadeObjectDetector('Nose');
eyesDetector = vision.CascadeObjectDetector('EyePairSmall');
mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',150);

videoFrame = imread('bey2.jpg');

facebbox = step(faceDetector, videoFrame);
faceImage = imcrop(videoFrame,facebbox(1,:));

nosebbox = step(noseDetector,videoFrame);
eyesbbox = step(eyesDetector,videoFrame);
mouthbbox = step(mouthDetector,videoFrame);


% Draw the returned bounding box around the detected face.
videoFrame = insertObjectAnnotation(videoFrame,'rectangle',facebbox,'Face');
videoFrame = insertObjectAnnotation(videoFrame,'rectangle',nosebbox,'Nose');
videoFrame = insertObjectAnnotation(videoFrame,'rectangle',eyesbbox,'Eyes');
videoFrame = insertObjectAnnotation(videoFrame,'rectangle',mouthbbox,'Mouth');
% Detect feature points in the face region.
%points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', nosebbox);

% Display the detected points.
figure, imshow(videoFrame), hold on, title('Detected features');
%plot(points);

