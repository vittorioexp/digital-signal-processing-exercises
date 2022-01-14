clc 
clear all
close all
% stable system
n=1:25;
nn=-5:25;
t=2.3351*exp(-1i*0.3502)*(-0.8).^n;
t=[0 0 0 0 0 0 t];
stem(nn,real(t))
title('Transient Real Part of y[n] for IIR filters')

ss=2.9188*exp(1i*0.2781)*exp(1i*0.2*pi*n);
ss=[0 0 0 0 0 0 ss];
figure
stem(nn,real(ss))
title('Steady-State Real Part of y[n] for IIR filters')

y=t+ss;
stem(nn,real(y))
title('Real Part of y[n] for IIR filters')

% unstable system
y2=((5*1.1)/(1.1-exp(1i*0.2*pi)))*(1.1).^n+(5/(1-1.1*exp(-1i*0.2*pi)))*exp(1i*0.2*pi*n);
y2=[0 0 0 0 0 0 y2];
figure
stem(nn,real(y2))
title('Steady-State Real Part of y[n] for unstable IIR filters')