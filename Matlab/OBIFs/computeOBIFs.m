function [obifs] = computeOBIFs(im, sigma, epsilon,configuration)
% COMPUTEBIFS - Computes basic images features
% 
% im            Image used for BIFs computation.
% sigma         Filter scale
% epislon       Amout of the image clasified as flat
% 
% ----- Literature References:
% Griffin et al. 
% Basic Image Features (BIFs) Arising from Approximate Symmetry Type. 
% Proceedings of the 2nd International Conference on Scale Space and Variational Methods in Computer Vision (2009)
%
% Griffin and Lillholm. 
% Symmetry sensitivities of derivative-of-Gaussian filters. 
% IEEE Trans Pattern Anal Mach Intell (2010) vol. 32 (6) pp. 1072-83
%
% Matlab implementation by  Nicolas Jaccard (nicolas.jaccard@gmail.com)

% Quantization
directionAngles=[
    0,... 
    -45,... 
    -90,... 
    -135,... 
    -180,... 
    180,... 
    135,... 
    90,... 
    45 ...
    ];


[bifs,jet] = computeBIFs(im,sigma,epsilon,configuration);

obifs = zeros(size(bifs));
obifs(bifs==1) = 1;

mask = bifs==2;

slope_gradient = atan2d(jet(3,:,:),jet(2,:,:));
slope_gradient = oBIFsQuantization(slope_gradient,directionAngles,size(im,1),size(im,2));
slope_gradient = uint8(slope_gradient);

slope_gradient(slope_gradient==6)=5;
slope_gradient(slope_gradient>5) =slope_gradient(slope_gradient>5)-1; 

obifs(mask) = 1+slope_gradient(mask);


gradient = atand((2*jet(5,:,:))./(jet(6,:,:)-jet(4,:,:)));
gradient = oBIFsQuantization(gradient,directionAngles,size(im,1),size(im,2));
gradient = uint8(gradient);

gradient(gradient==5 | gradient==6) = 1;
gradient(gradient==7) = 2;
gradient(gradient==8) = 3;
gradient(gradient==9) = 4;

mask = bifs==3;
obifs(mask) = 10;

mask = bifs==4;
obifs(mask) = 11;

mask = bifs==5;
obifs(mask) = 11+gradient(mask);

mask = bifs==6;
obifs(mask) = 15+gradient(mask);

mask = bifs==7;
obifs(mask) = 19+gradient(mask);


end



