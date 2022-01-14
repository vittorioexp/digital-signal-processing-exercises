% Decoding a Universal Product Code (UPC)

clear all;
close all;


% Read the imahe
A = imread('UPC4.PNG');
A = rgb2gray(A);
image(A);


% Select specif row of the figure
m_0 = 60;
x = A(m_0, 1:end);


figure()
plot(x);
xlabel('samples');
ylabel('x[n]');
hold on;


% Specify filter coefficients and filter using conv
% 1 * y(n) = 1 * x(n) - 1 * x(n - 1)

h = [1, -1]; % First difference filter 
y = conv(x, h, 'valid');


figure()
stem(y,'r');
hold on;
stem(x,'b*');
ylabel('x[n] (blue) and y[n] (red)');
xlabel('samples');
hold on;


% Threshold Operator

threshold = 200 % Found observing the data
d = y;
d(abs(y) < threshold) = 0;
d(abs(y) >= threshold) = 1;

%Convert to Locations

figure()
stem(d,'-*');
xlabel('samples');
ylabel('d[n]');
d = d(1,:);
l = find(d);

% Apply a first-difference filter to the location signal

Delta_n = conv(l, h, 'valid');

figure()
subplot(2,1,1);
stem(Delta_n);
ylabel('Delta_n');
xlabel('samples');
subplot(2,1,2);
stem(l);
ylabel('l[n]');
xlabel('samples');


% Estimate the pixel width of the thinnest bar
w_b = sum(Delta_n(1:end))/95;

% Normalize Delta_n by the estimated w_b
Delta_n = Delta_n/w_b;


% Round the obtained values

for n=1:length(Delta_n)
    if (Delta_n(1,n) > 0.5 && Delta_n(1,n)<=1.5)
        Delta_n(1,n)=1;
    end
    
    if (Delta_n(1,n) > 1.5 && Delta_n(1,n)<=2.5)
        Delta_n(1,n)=2;
    end
        
    if (Delta_n(1,n) > 2.5 && Delta_n(1,n)<=3.5)
        Delta_n(1,n)=3;
    end
    
    if (Delta_n(1,n) > 3.5 && Delta_n(1,n)<=4.5)
        Delta_n(1,n)=4;
    end
end

barcodearray=Delta_n;


decodeUPC(barcodearray);

% Print the digits resulting from the processing
disp(ans)
