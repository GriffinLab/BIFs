function displayBIFsTest(bifs,handle)
%DISPLAYBIFS Display BIFs as computed by the computeBIFs
% Used to display BIFs with the original Mathematica implementation
% colormap
%
% Note: should _not_ be used to display filterd images, used the
% binarize option of the filterBIFs functio and display the image using
% imshow(bifs).
%
% bifs = BIFs as computed by the compteBIFs function
%
% Matlab implementation by  Nicolas Jaccard (nicolas.jaccard@gmail.com)

% Load the BIF color map
load('BIFColorMap','mycmap')

% Display the imge
if(nargin>1)
    fh = figure(handle);
    set(fh, 'Name','BIF','Units', 'pixels', 'visible', 'on');
else  
    fh=figure('Name','BIF','Units', 'pixels', 'visible', 'on');
end
imshow(ind2rgb(bifs,colormap(mycmap)));

end

