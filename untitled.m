faceDetector = vision.CascadeObjectDetector();
originalImage = imread('beyonceCrop.png');
bbox = step(faceDetector, originalImage);

% Draw the returned bounding box around the detected face.
videoOut = insertObjectAnnotation(originalImage,'rectangle',bbox,'Face');
figure, imshow(videoOut), title('Detected face');

[hueChannel,~,~] = rgb2hsv(originalImage);

figure, imshow(hueChannel), title('Hue channel data');
rectangle('Position',bbox(1,:),'LineWidth',2,'EdgeColor',[1 1 0])

noseDetector = vision.CascadeObjectDetector('Nose');
faceImage    = imcrop(originalImage,bbox(1,:));
noseBBox     = step(noseDetector,faceImage);