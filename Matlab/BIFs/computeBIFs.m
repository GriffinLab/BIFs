function [bifs,jet] = computeBIFs(im, sigma, epsilon,configuration)
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

%Check if an image parameter has been specified
if(~exist('im','var')) 
    error('No image specified!');
elseif(~exist('sigma','var') || ~exist('epsilon','var'))
    error('Sigma and/or epsilon not specified!');
end

if(nargin<4)
    configuration = 1;
end


% Load image and normalize
if(~strcmp(class(im),'double'))
    if(~(ndims(im)==3))
        im = double(im)/255;
    else
        im = double( rgb2gray( im ) )/255;
    end
end

% Dervative orders list
orders=[0, 0; 1, 0; 0, 1; 2, 0; 1, 1;0, 2];

% Compute jets
jet = zeros(6,size(im,1),size(im,2));

% Do the actual computation

DtGfilters = DtGfiltersBank(sigma);

for i=1:size(orders,1)
    jet(i,:,:)=efficientConvolution(im,DtGfilters{i,1},DtGfilters{i,2})*(sigma^(sum(orders(i,:))));
end
    

if(configuration==1)

    % Compute lambda and mu
    lambda=(squeeze(jet(4,:,:))+squeeze(jet(6,:,:)));
    mu=sqrt(((squeeze(jet(4,:,:))-squeeze(jet(6,:,:))).^2)+4*squeeze(jet(5,:,:)).^2);

    % Initialize classifiers array
    c = zeros(size(jet,2),size(jet,3),7);

    % Compute classifiers
    c(:,:,1) = epsilon*squeeze(jet(1,:,:));
    c(:,:,2) = 2*sqrt(squeeze(jet(2,:,:)).^2+squeeze(jet(3,:,:)).^2);
    c(:,:,3) = lambda;
    c(:,:,4) = -lambda;
    c(:,:,5) = 2^(-1/2)*(mu+lambda);
    c(:,:,6) = 2^(-1/2)*(mu-lambda);
    c(:,:,7) = mu;
    
else
        
    % Compute lambda and mu
    lambda=0.5*(squeeze(jet(4,:,:))+squeeze(jet(6,:,:)));
    mu=sqrt(0.25*((squeeze(jet(4,:,:))-squeeze(jet(6,:,:))).^2)+squeeze(jet(5,:,:)).^2);

    % Initialize classifiers array
    c = zeros(size(jet,2),size(jet,3),7);

    % Compute classifiers
    c(:,:,1) = epsilon*squeeze(jet(1,:,:));
    c(:,:,2) = sqrt(squeeze(jet(2,:,:)).^2+squeeze(jet(3,:,:)).^2);
    c(:,:,3) = lambda;
    c(:,:,4) = -lambda;
    c(:,:,5) = 2^(-1/2)*(mu+lambda);
    c(:,:,6) = 2^(-1/2)*(mu-lambda);
    c(:,:,7) = mu;  

end

% Each pixel of the image is assigned to the largest classifier
[C,bifs] = max(c,[],3);
end