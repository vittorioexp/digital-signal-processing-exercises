clc
clear all
close all

% Delay system
bb = [0,1,0]; %-- Filter Coefficients
ww = -pi:(pi/100):pi; %-- omega hat
HH = freqz(bb, 1, ww); 
subplot(2,1,1);
plot(ww, abs(HH))
xlim([-3,3])
title('Real part of a delay system')
subplot(2,1,2);
plot(ww, angle(HH))
xlim([-3,3])
title('Phase angle of a delay system')
xlabel('Normalized Radian Frequency')
print -djpeg delay.jpg

% First difference system, highpass filter
bb = [1,-1]; %-- Filter Coefficients
ww = -3*pi:(pi/100):3*pi; %-- omega hat
HH = freqz(bb, 1, ww); 
subplot(2,1,1);
plot(ww, abs(HH))
xlim([-9,9])
title('Magnitude of frequency response of a first-difference system')
subplot(2,1,2);
plot(ww, angle(HH))
xlim([-9,9])
title('Phase angle of frequency response of a first-difference system')
xlabel('Normalized Radian Frequency')
print -djpeg firstdifference.jpg

subplot(2,1,1);
plot(ww, 1-cos(ww))
xlim([-9,9])
title('Real part of frequency response of a first-difference system')
subplot(2,1,2);
plot(ww, sin(ww))
xlim([-9,9])
title('Imaginary part of frequency response of a first-difference system')
xlabel('Normalized Radian Frequency')
print -djpeg firstdifferencereim.jpg

% Lowpass filter
subplot(2,1,1);
plot(ww, 2+2*cos(ww))
xlim([-3,3])
title('Magnitude of frequency response of a lowpass filter')
subplot(2,1,2);
plot(ww, -ww)
xlim([-3,3])
title('Phase angle of frequency response of a lowpass filter')
xlabel('Normalized Radian Frequency')
print -djpeg lowpass.jpg

% 11-point running-average filter
subplot(2,1,1);
plot(ww, diric(ww,11))
xlim([-3,3])
title('Magnitude of frequency response of an 11-point running-average filter')
subplot(2,1,2);
plot(ww, -5*ww)
xlim([-3,3])
title('Phase angle of frequency response of an 11-point running-average filter')
xlabel('Normalized Radian Frequency')
print -djpeg 11point.jpg