% Daniele Orsuti
% DSP lab. a.y. 21/22
% daniele.orsuti@phd.unipd.it

close all;
clear all;

%% Define parameters and input noisy signal
fs = 8000; % Sampling rate
T = 1 / fs; % Sampling period
v = sqrt(0.1) * randn(1,250); % Generate Gaussian random noise
n = 0:1:249; % Indexes
x = sqrt(2) * sin(2 * pi * 500 * n * T) + v; % Generate 500-Hz plus noise

%% Design the LPF and filter the signal
Wnc=2*pi*900/fs; % Determine the normalized digital cutoff frequency

wc = Wnc;
M = 135;
alpha = (M-1)/2; 
nn = [0:1:(M-1)];
m = nn - alpha; fc = wc / pi; hd = fc * sinc(fc * m);
B = hd.* hamming(M).';

figure;
freqz(B,1,1024);
title('Frequency response of the designed filter');


y=filter(B,1,x); % Perform digital filtering

%% Show the results

% Time domain plots
figure;
subplot(2,1,1); stem(n,x); 
title('Input signal'); xlabel('Number of samples');ylabel('Sample value'); grid;

%Please note the delay introduced by the filter on the output signal
subplot(2,1,2); stem(n,y);
title('Output signal'); xlabel('Number of samples');ylabel('Sample value'); grid;


% Frequency domain plot
figure;
freqz(x,1024,fs); 
title('Frequency response of the input signal');
figure;
freqz(y,1024,fs);
title('Frequency response of the output signal');