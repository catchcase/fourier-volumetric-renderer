# Fourier Volumetric Renderer

###### Vincente A. Campisi

### Contents:
```
- 4 Matlab scripts
- 1 Matlab function
- 6 images
- 2 vol data files
```
——-

##### Note: This repository is a repackaging/restructuring of the original and it is necessary to update the provided relative file paths!


There are several Matlab scripts and one Matlab function (render.m). The following is the documentation for the render function:

```
function outputImage = render( inputFile, lightPosition, xDeg, yDeg, zDeg, outputFileName )
%render() This function implements basic Fourier volume rendering to save a
% 2D projection as an image file.
%   inputFile - the input file name
%   lightPosition - not implemented
%   xDeg - number of degrees to roll the image (clockwise)
%   yDeg - number of degrees to pitch the image (clockwise)
%   zDeg - number of degrees to yaw the image (clockwise)
%   outputFileName - the desired name of the output image 
%       (e.g. 'example.png')
```

———

The xDeg, yDeg and zDeg parameters specify how much to rotate the volume on the respective axis. The included Axes.png image shows a visual representation of this ([source](https://tex.stackexchange.com/q/118055)).

——-

The defaultPosition.png image shows how the image will be displayed when xDeg, yDeg and zDeg are all 0. Any rotation(s) is/are performed from this position.

——-

The output file name should include the file extension.

——-

Please run the included Matlab scripts to view several different outputs using various input images and parameters. You may need to move several files or specify absolute paths.

——-

The scripts and images are labeled according to the input data and the chosen x, y and z parameters. The included images with the ‘PRERENDERED’ suffix are provided for comparison/example. The scripts will create identical output images but without this suffix.

——-

The included vol data files are tomato.vol and uncbrain.vol [source](http://vda.univie.ac.at/Teaching/Vis/Data/Volumes/)