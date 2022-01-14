clear all;
close all; 

load('y_echo.mat');
y = y_echo;
Fs = 44100;


figure;
plot(-(length(y)-1):length(y)-1,xcorr(y,'coeff'));
xlabel('samples');
ylabel('Auto correlation');
grid;


N = 2.205*1e4; % delay in samples found looking at the previous plot
a = 0.75;

% Remove the echo

x(1:N)=y(1:N); % First N samples of x and y agree

for i=N+1:length(y)

x(i)=y(i) - a * x(i-N); % Inverse filtering

end

figure;
subplot(211)

plot(y); % Plot signal with echo

title('Signal with echo');

subplot(212)

plot(x); % Plot signal without echo

title('Signal withou echo');

% Reproduce files

pause(5);
sound(y,Fs); % Listen to signal with echo
pause(5);

sound(x,Fs); % Listen to signal without echo

pause(5);

% 
% % Alternative implementation with filter function
% b = 1;
% a = 0.75;
% a = [1; zeros(N-1,1); 0.75];
% out = filter(b,a,y);
% sound(out,Fs);
