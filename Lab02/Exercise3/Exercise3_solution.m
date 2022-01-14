% Daniele Orsuti
% DSP lab. a.y. 21/22
% daniele.orsuti@phd.unipd.it

clear all;
close all;

%% Design the fitler using the window method
M = 21; alpha = (M-1)/2; n = 0:M-1;
hd = (cos(pi*(n-alpha)))./(n-alpha); hd(alpha+1)=0;
w_ham = (hamming(M))'; h = hd .* w_ham; 


%% plots
subplot(2,2,1); stem(n,hd); title('Ideal Impulse Response')
axis([-1 M -1.2 1.2]); xlabel('n'); ylabel('hd(n)'); grid;
subplot(2,2,2); stem(n,w_ham);title('Hamming Window')
axis([-1 M 0 1.2]); xlabel('n'); ylabel('w(n)'); grid;
subplot(2,2,3); stem(n,h);title('Actual Impulse Response')
axis([-1 M -1.2 1.2]); xlabel('n'); ylabel('h(n)'); grid;

% Below 1024 means that the frequency response is evaluated over 1024 
% points.
figure();
freqz(h,1,1024);
title('Second method- Freq. response');

%% Create signal which will be filterd
n=[0:100]; % samples axis associated to signal y
freq = 0.1;
y = cos(freq * pi * n); 

% Suggestion: plot in the frequency domain the signal 'y' to check
% where the tone is centered in the frequency domain
% use: freqz(y, 1, 1024);

%% Fitler the signal
z = filter(h,1,y);
z = z((length(h)+1)/2:end); % Remove filte delay

Nz = length(z); % length of the filtered signal
nz = (0:Nz-1); % samples of the filtered signals

%% Compute the expected derivative

%z_exp stands for expected derivative signal
z_exp= -1 * freq * pi * sin(freq * pi * n);
figure;

stem(n,y);
hold on;
stem(nz,z);
hold on;
stem(n,z_exp);
hold on;

% On the plot the corrupted samples at the beginningare due to the
% transient response.
title('Original and Filtered signal in time domain')
hold on;
grid; 
xlabel('samples [s]'); 
ylabel('amplitude'); 
legend('Original','Filtered','Expected derivative')
hold off;
