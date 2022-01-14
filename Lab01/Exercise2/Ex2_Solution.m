clear all;
close all;

I = imread('test.jpg');
figure,imagesc(I);title('Original Image');
I = rgb2gray(I);
I = double(I);
figure,imagesc(I);colormap(gray);title('Original Image B&W');


%Define the window dimension
sz = 3;
mn=floor(sz/2);

%Define the matrix containing the result
Output = zeros(size(I));

%Zero padding
I = padarray(I,[mn mn]);

for i=1:size(I,1)-mn*2
    
    for j=1:size(I,2)-mn*2
        
        tmp = I(i:i+(sz-1),j:j+(sz-1));
        mu = mean(tmp(:));
        
        tmp2 = mean(tmp(:).^2);
        Output(i,j)=tmp2 - mu.^2;
        
    end
end

figure,imagesc(Output);colormap(gray);


%Define a Threshold
meanL = mean(Output(:));

%Set the pixel values based on threshold
Edges = zeros(size(Output));
Edges(Output < meanL)=1;
Edges(Output >= meanL) = 0;

figure,imagesc(Edges);colormap(gray);title('Edges detected');


% % The code writted above can be simplified with conv.
% %Define the window size
% sz=3;
% window = ones(sz)/sz.^2;
% 
% %Find the local mean
% mu = conv2(I,window,'same');
% 
% %Find the local Variance
% II = conv2(I.^2,window,'same');
% Lvar = II-mu.^2;