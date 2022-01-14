% Daniele Orsuti
% DSP lab. a.y. 21/22
% daniele.orsuti@phd.unipd.it

clear all;
close all;


%% First task - rect
wp = 0.2*pi; ws = 0.3*pi; tr_width = ws - wp;
wc = (ws+wp) / 2;
M = 45;


alpha = (M-1)/2; 
n = [0:1:(M-1)];
m = n - alpha; fc = wc / pi; hd = fc * sinc(fc * m);


% freqz_m is just a function (see at the end of the code) that uses freqz
% in this exercise mag, pha, grd are not considered.
[db,mag,pha,grd,w] = freqz_m(hd,1);

% plots
figure();
subplot(2,2,1); stem(n,hd); title('Ideal Impulse Response');grid;
axis([0 M-1 -0.1 0.3]); xlabel('n'); ylabel('hd(n)')
subplot(2,2,2); stem(n,hd);title('Rectangular Window');grid;
axis([0 M-1 -0.5 1.1]); xlabel('n'); ylabel('w(n)')
subplot(2,2,3); stem(n,hd);title('Actual Impulse Response'); grid;
axis([0 M-1 -0.1 0.3]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4); plot(w/pi,db);title('Magnitude Response in dB');grid;
axis([0 1 -100 10]); xlabel('frequency in pi units'); ylabel('Decibels'); 

%% First task - hamming

M = ceil(6.6*pi/tr_width) + 1 % 67 taps

n=[0:1:M-1];

hd = ideal_lp(wc,M); w_ham = (hamming(M))'; h = hd .* w_ham;

[db,mag,pha,grd,w] = freqz_m(h,1); 

% On the line below, 1000 is the number of samples onto which the 
% frequency response is evaluated. delta_w is the step in the frequency
% domain. It is used to evaluate numerically (i.e., from the plot) Rp and 
% As values. 
% In other words we divide the whole freuquency range onto which the 
% frequency response is evaluated ([0,2pi]) by the number of points used to 
% compute the freq. response, this way we obtain the frequency step.
delta_w = 2 * pi / 1000; 


% Compute Rp from the plot
Rp = -(min(db(1:1: wp / delta_w + 1))); % Actual Passband Ripple is Rp = 0.0394

As = -round(max(db(ws/delta_w+1:1:501))); % Min Stopband attenuation is As = 52


% plots
figure;
subplot(2,2,1); stem(n,hd); title('Ideal Impulse Response')
axis([0 M-1 -0.1 0.3]); xlabel('n'); ylabel('hd(n)')
subplot(2,2,2); stem(n,w_ham);title('Hamming Window')
axis([0 M-1 0 1.1]); xlabel('n'); ylabel('w(n)')
subplot(2,2,3); stem(n,h);title('Actual Impulse Response')
axis([0 M-1 -0.1 0.3]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4); plot(w/pi,db);title('Magnitude Response in dB');grid
axis([0 1 -100 10]); xlabel('frequency in pi units'); ylabel('Decibels')

%% Second task
ws1 = 0.2*pi; wp1 = 0.35*pi; wp2 = 0.65*pi; ws2 = 0.8*pi; As = 60;
tr_width = min((wp1 - ws1),(ws2 - wp2)); M = ceil(11*pi / tr_width) + 1
%M = 75
n=[0:1:M-1]; wc1 = (ws1 + wp1) / 2; wc2 = (wp2 + ws2) / 2;
hd = ideal_lp(wc2,M) - ideal_lp(wc1,M);
w_bla = (blackman(M))'; h = hd .* w_bla;

[db, mag, pha, grd,w] = freqz_m(h,[1]); delta_w = 2*pi/1000;

Rp = -min(db(wp1 / delta_w + 1:1: wp2 / delta_w)) % Actual Passband Ripple
%Rp = 0.0030
As = -round(max(db(ws2 / delta_w + 1:1:501))) % Min Stopband Attenuation
%As = 75

%Plots
figure;
subplot(2,2,1); stem(n,hd); title('Ideal Impulse Response');grid;
axis([0 M-1 -0.4 0.6]); xlabel('n'); ylabel('hd(n)')
subplot(2,2,2); stem(n,w_bla);title('blackmann Window');grid;
axis([0 M-1 0 1.1]); xlabel('n'); ylabel('w(n)')
subplot(2,2,3); stem(n,h);title('Actual Impulse Response');grid;
axis([0 M-1 -0.4 0.6]); xlabel('n'); ylabel('h(n)')
subplot(2,2,4); plot(w/pi,db);title('Magnitude Response in dB');grid
axis([0 1 -100 10]); xlabel('frequency in pi units'); ylabel('Decibels')
%% Fourth task

fs1 = 0.2;
fp1 = 0.35;
fp2 = 0.65;
fs2 = 0.8;

%The following vector specifies the maximum allowable deviation or ripples
%between the frequency response and the desired amplitude of the output 
%filter for each band.

Rp = 1 %dB 

% obtain delta_1
temp = 10^(- Rp / 20);
delta_p = (1 - temp) / (temp + 1);

Rs = 60; %dB
err_lim = [10^(-Rs/20) delta_p  10^(-Rs/20)]; % required limits (weights)

%Find the estimate order N of the filter
[N,Fo,Ao,W] = firpmord([fs1 fp1 fp2 fs2],[0 1 0],err_lim);
N= 2*ceil(N/2);% It must be an even number
N_actual=N+2; % increase by 2 to meet requirements
disp(['firpmord suggests a filter of order of: ', num2str(N), ' we use: ',  num2str(N_actual)]);
b = firpm(N_actual, Fo, Ao, W);
figure();
freqz(b, 1, 1024);

% Check that the specifications are met
[db,mag,pha,grd,w] = freqz_m(b,1);
delta_w = 2 * pi / 1000; % Frequency step
fs2i=floor(fs2 * pi / delta_w) + 1;
fp1i=floor(fp1 * pi / delta_w) + 1;
fp2i=floor(fp2 * pi / delta_w) + 1;
f_Nyquist = floor(pi / delta_w) + 1;

Asd = -max(db(fs2i:f_Nyquist));
disp(['Actual stop-band attentuation [dB]:', num2str(Asd)])
Rp = -min(db(fp1i:1:fp2i)); % Actual Passband Ripple
disp(['Actual pass-band ripple [dB]:', num2str(Rp)])

%% Functions

function hd = ideal_lp(wc,M);
% Ideal LowPass filter computation
% --------------------------------
% [hd] = ideal_lp(wc,M)
% hd = ideal impulse response between 0 to M-1
% wc = cutoff frequency in radians
% M = length of the ideal filter
%
alpha = (M-1) / 2; 
n = [0:1:(M-1)];
m=n- alpha; 
fc = wc / pi; 
hd = fc * sinc(fc * m);
end


function [db,mag,pha,grd,w] = freqz_m(b,a);
% Modified version of freqz subroutine
% ------------------------------------
% [db,mag,pha,grd,w] = freqz_m(b,a);
% db = Relative magnitude in dB computed over 0 to pi radians
% mag = absolute magnitude computed over 0 to pi radians
% pha = Phase response in radians over 0 to pi radians
% grd = Group delay over 0 to pi radians
% w = 501 frequency samples between 0 to pi radians
% b = numerator polynomial of H(z) (for FIR: b=h)
% a = denominator polynomial of H(z) (for FIR: a=1)
%

% the whole option returns the frequency reponse over the whole unit circle
% i.e., 0 to 2pi.
% 1000 means that the frequency response is evaluated on 1000 samples
[H,w] = freqz(b,a,1000,'whole'); 
H = (H(1:1:501))'; % consider only from 0 to pi 
w = (w(1:1:501))';
mag = abs(H); 
db = 20*log10((mag+eps)/max(mag)); % eps is to avoid log(0)
pha = angle(H); 
grd = grpdelay(b,a,w); % This returns the filter delay
end