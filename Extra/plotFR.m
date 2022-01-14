clc
clear all

% we read  the filter coefficients and define the vectors aa and bb as 
bb=[2 2]; % coefficients of the numerator
aa=[1 -0.8]; % coefficients of the denumerator
ww = 2*pi*[-1:.005:1] ; % considered frequency interval
HH = freqz( bb, aa,  ww ); % computation of the frequency response
subplot(2,1,1);
plot(ww, abs(HH))
xlim([-6,6])
title('Magnitude of frequency response of a first-difference system')
subplot(2,1,2);
plot(ww, angle(HH))
xlim([-6,6])
title('Phase angle of frequency response of a first-difference system')
xlabel('Normalized Radian Frequency')
figure
zplane(bb,aa) % plot zero - pole distribution
