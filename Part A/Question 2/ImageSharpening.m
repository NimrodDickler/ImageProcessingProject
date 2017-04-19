%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Processing - Final Project
% Part A: Single image processing
% Question 2: Image Sharpening
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Define paths for files
sourceImagePath = '.\imgs\Tiger.jpg';
destImagePath = '.\imgs\Tiger_Sharp.jpg';

% Get the original image and convert it to a greyscale image if needed
sourceImage = imread(sourceImagePath);
if size(sourceImage,3)==3
    sourceImage = rgb2gray(sourceImage);
end

figure('Name','Image Before Sharpening','NumberTitle','off'),imshow(sourceImage);

% Run the image sharpning function and compare the results
sharpRate = 5;
sharpImage = ImageSharpeningFunction(sourceImage,sharpRate);
figure('Name','Image After Sharpening','NumberTitle','off'),imshow(sharpImage);
imwrite(sharpImage,destImagePath);


