% Daniele Orsuti
% DSP lab. a.y. 21/22
% daniele.orsuti@phd.unipd.it

clear all;
close all;

%% First task
[xx, fs] = audioread('SunshineSquare.wav');

% The following commands can be used to listed to the original audio signal
% (keep the volume low)

%pause(2);
%sound(xx,fs);

xx = xx';
figure;
spectrogram(xx, fs);
%% Second task

%Define frequencies to notch (determined from previous spectrogram plot)
w1 = 0.2857
w2 = 0.5709;
w3 = 0.8573;

% First impulse response
AA1 = -2*cos(w1 * pi);
hh1 = [1, AA1, 1];
hh1 = hh1/ (2-2*cos(w1*pi)); % Normalize to obtain unit DC gain


% Second imoulse response
AA2 = -2*cos(w2 * pi);
hh2 = [1, AA2, 1];
hh2 = hh2 / (2-2*cos(w2*pi));

% Third impulse response
AA3 = -2*cos(w3 * pi);
hh3 = [1, AA3, 1];
hh3 = hh3 / (2-2*cos(w3*pi));


%Overall cascaded impulse response obtained convolving the individual
%responses
hh_out = conv(hh1, hh2); 
hh_out = conv(hh_out, hh3);


% With respect to Exercise 1 we use a different way to plot the frequency
% response (just to present different alternatives). ww is the frequency
% vector 1/100 is the frequency step.
ww = -pi:pi/100:pi; 
HH = freqz(hh_out, 1 ,ww);

% Plots
figure;

subplot(2,1,1);
plot(ww/pi,20*log10(abs(HH))); 
title('Magnitude impulse response of cascaded filters');
ylabel('Magnitude [dB]'); xlabel('Norm. frequency'); grid;

subplot(2,1,2)
plot(ww/pi,unwrap(angle(HH)));
title('Phase impulse response of cascaded filters'); grid;
ylabel('Phase'); xlabel('Norm. frequency');


yy = filter(hh_out,1,xx);

pause(2);
sound(yy,fs);

% Output spectrogram
figure;
spectrogram(yy, fs);
