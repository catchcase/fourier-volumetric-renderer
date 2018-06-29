% Vincente A. Campisi
% 2017

function outputImage = render( inputFile, lightPosition, xDeg, yDeg, zDeg, outputFileName )
%render() This function implements basic fourier volume rendering to save a
% 2D projection as an image file.
%   inputFile - the input file name
%   lightPosition - not implemented
%   xDeg - number of degrees to roll the image (clockwise)
%   yDeg - number of degrees to pitch the image (clockwise)
%   zDeg - number of degrees to yaw the image (clockwise)
%   outputFileName - the desired name of the output image 
%       (e.g. 'example.png')

% Open file and get header information
volfile = fopen(inputFile, 'r');
dimensions = str2num(fgetl(volfile));

% Get dimensions from header information
width = dimensions(1);
height = dimensions(2);
depth = dimensions(3);

% Set dimensions and find min and max dimension values
dimensionSet = [height, width, depth];
maxDim = max(dimensionSet);
minDim = min(dimensionSet);

% Read file data and reshape to 3D grid
volData = fread(volfile);
spatialRep = reshape(volData, [width, height, depth]);

% Pad 3D grid so that all dimensions are equal length
padAmount = floor((maxDim - minDim) / 2);
spatialRep = padarray(spatialRep, [0 0 padAmount]);

% If the dimension(s) are odd/unequal, add one unit of padding
if size(spatialRep, 3) == (maxDim - 1)
    spatialRep = padarray(spatialRep, [0 0 1], 'post');
end

% Shift in spatial domain
spatialRep = fftshift(spatialRep);

% Perform 3D FFT to get frequency domain representation of volume
freqRep = fftn(spatialRep);

% Shift in frequency domain
freqRep = fftshift(freqRep);

% Set up mesh grid and dimensions for slice
m = -(maxDim / 2):1:(maxDim / 2) - 1;
s = linspace(-maxDim / 2, maxDim / 2 , maxDim);
[X, Y, Z] = meshgrid(m, m, m);

% Create slice surface
extractedSlice = surface(s, s, zeros((maxDim), (maxDim)));

% Rotate the slice, depending on eye position parameter
rotate(extractedSlice, [0,0,1], -90);
rotate(extractedSlice, [0, 0, 1], -xDeg);
rotate(extractedSlice, [0, 1, 0], -yDeg);
rotate(extractedSlice, [1, 0, 0], -zDeg);

% Extract XYZ dimensional data
x = get(extractedSlice,'XData');
y = get(extractedSlice,'YData');
z = get(extractedSlice,'ZData');

% Interpolate using volume and slice data
iSlice = interp3(X, Y, Z, freqRep, x, y, z);

% Replace undefined values with zeros
iSlice(isnan(iSlice)) = 0;

% Shift slice in frequency
iSlice = fftshift(iSlice);

% Inverse 2D FFT to get 2D spatial representation 
outputImage = ifft2(iSlice);

% Shift in spatial domain
outputImage = fftshift(outputImage);

% Take absolute values
outputImage = abs(outputImage);

% Prepare to write to image
outputImage = mat2gray(outputImage);

% Write final 2D projection to image file
imwrite(outputImage, outputFileName);

end

