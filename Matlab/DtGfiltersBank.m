function DtGkernels = DtGfiltersBank(sigma,configuration)
% DTGFILTERSBANK Generates the Derivative-of-Gaussian (DtG) kernels for the computation of
% BIFs. 

if(nargin<2)
    configuration = 1;
end

x = -5*sigma:5*sigma;
xSquared = x.^2;

DtGkernels = cell(6,2);

% Use configuration 1 to get identical response to legacy method
if(configuration==1)
    
    baseKernel = exp(-xSquared./(2*sigma^2));
    dKernel{1} = (1/(sqrt(2)*sigma)).*baseKernel;
    dKernel{2} = -x.*(1/(sqrt(2)*sigma^3)).*baseKernel;
    dKernel{3} = (xSquared-sigma^2).*(1/(sqrt(2)*sigma^5)).*baseKernel;
    
    orders=[0, 0; 1, 0; 0, 1; 2, 0; 1, 1;0, 2];
    
    for i=1:size(orders,1)
        DtGkernels{i,2} = dKernel{orders(i,1)+1};
        DtGkernels{i,1} = dKernel{orders(i,2)+1};
    end
    
else
    
    % Compute the 0,0 order kernel
    G=fspecial('gaussian',[numel(x), numel(x)], sigma);
    
    % Compute the 1,0 and 0,1 order kernels
    [Gx,Gy] = gradient(G);
    
    % Compute the 2,0, 1,1 and 0,2 order kernels
    [Gxx,Gxy] = gradient(Gx);
    [Gyx,Gyy] = gradient(Gy);
    
    kernels{1} = G;
    kernels{3} = Gx;
    kernels{2} = Gy;
    kernels{6} = Gxx;
    kernels{5} = Gxy;
    kernels{4} = Gyy;
end
end

