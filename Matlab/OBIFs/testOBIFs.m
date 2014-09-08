%% Comparison with Mathematica output

I = imread('letter.png');

I = im2double(I);

I = rgb2gray(I);

sigma = 1;
epsilon = 0.014;


OBIFs = computeOBIFs(I,sigma,epsilon,2);
displayOBIFs(OBIFs)

%% Test with image inversion

I = imread('letter.png');

I = im2double(I);

I = rgb2gray(I);

I=imresize(I,[50 50]);

tmp = zeros(size(I));
tmp(:,:) = max(max(I));
I = tmp - I;

sigma = 1.6;
epsilon = 0.015;


OBIFs = computeOBIFs(I,sigma,epsilon,2);
OBIFs=flipdim(OBIFs ,1); 
displayOBIFs(OBIFs)

min(min(OBIFs))
max(max(OBIFs))