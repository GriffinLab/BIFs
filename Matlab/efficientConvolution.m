function J=efficientConvolution(I,kx,ky)
%EFFICIENTCONVOLUTION Convolution of an image using two separable 1-D kernels
    J = imfilter(I,kx,'replicate', 'same','conv');
    J = imfilter(J,ky','replicate', 'same','conv');
end

