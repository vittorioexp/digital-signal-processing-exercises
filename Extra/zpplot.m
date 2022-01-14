clear all
close all
clc

% Complex poles
% Zero-pole plot of h[z]=(2+2z^-1)/(1-z^-1+z^-2)
bb=[2 2];
aa=[1 -1 1];
zplane(bb,aa)

% Distinct an real poles
% Zero-pole plot of h[z]=1/(1-5/6z^-1+1/6z^-2)
bb=[1];
aa=[1 -5/6 1/6];
zplane(bb,aa)

% Plot of the impulse response h=4*cos((2*pi/6)*(n-1));
n=1:20;
h=4*cos((2*pi/6)*(n-1));
nn=-5:20;
h=[0 0 0 0 0 0 h];
stem(nn,h)

% Zero-pole and impulse response plot of h=4*cos((2*pi/4)*(n));
bb=1;
aa=[1 0 1];
zplane(bb,aa);
n=1:20;
h=4*cos((2*pi/4)*(n));
nn=-5:20;
h=[0 0 0 0 0 0 h];
figure
stem(nn,h)

% Zero-pole and impulse response plot of h=2/sqrt(3)*(0.5).^n*cos(pi/3-pi/6);
bb=1;
aa=[1 -0.5 0.25];
zplane(bb,aa);
n=1:20;
h=2/sqrt(3)*(0.5).^n.*cos(n*pi/3-pi/6);
nn=-5:20;
h=[0 0 0 0 0 0 h];
figure
stem(nn,h)

% Plot the frequency response of y[n]= 0.9y[n − 1]− 0.81y[n − 2]+ x[n]− x[n − 2]
aa= [1 -0.9 0.81];
bb=[1 0 -1];
t=-pi:(pi/100):pi;
HH = freqz(bb, aa,t);
subplot(2,1,1)
plot(t,abs(HH))
subplot(2,1,2)
plot(t,angle(HH))
figure
zplane(bb,aa)