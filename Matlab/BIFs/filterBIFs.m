function [filteredBifs] = filterBIFs(bifs, features, binarize)
% FILTERBIFS - Extract specific feature from BIFs computed using the
% computeBIFs function
% 
% bifs          BIFs computed using the computeBIFs function
% features      Vector containing the features to extract (valid values
%               range from 1 to 7)
% binarize      Set pixels with extracted features to 1, otherwise 0
%
% Matlab implementation by  Nicolas Jaccard (nicolas.jaccard@gmail.com)

% Possible feature reference vector 
reference = [1 2 3 4 5 6 7];

% Compute the features to remove (features appearing in the reference but
% not in the input parameter)
toRemove = setdiff(reference, features);

% Remove unwanted features (set to 0)
for i=1:numel(toRemove)
    bifs(bifs==toRemove(i))=0;
end

% If necessary, set all non-0 values to 1 to produce a binary image
if(binarize) bifs(bifs~=0) = 1; end;

% Set the return variable
filteredBifs=bifs;
end
