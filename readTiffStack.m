function [imMat] = readTiffStack(filename)
%readTiffStack Read a tiff stack
%   Uses MATLAB's built in iminfo and imread to read in multi-page tiff
%   stack files.

info = imfinfo(filename);
numImages = numel(info);
%pre-allocate matrices
imMat = zeros([info(1).Height, info(1).Width, numImages]);
for n = 1:numImages
    imMat(:,:,n) = imread(filename, n);
end
end

