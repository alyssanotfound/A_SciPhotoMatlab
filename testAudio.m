clc; clear all; close all;
afile = 'mariah.wav';
[y,Fs]=wavread(afile);
nsamples = 10 * Fs;
[y2, Fs] = wavread(afile, nsamples);

sound(y2, Fs);

%gives secs
t=0:1/Fs:(length(y2)-1)/Fs;

figure(1);
axis([0,10,-5,5])
plot(t,y2(:,2));
[pks,locs] = findpeaks(y2(:,2),'minpeakdistance',10000);
pkSecs = t(locs);
pkFrames = round(pkSecs/0.033333);
disp(pkFrames);



 