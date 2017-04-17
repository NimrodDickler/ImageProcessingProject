

%Question 2 Image Sharpning
%{
sourceImagePath = 'D:\Git\Private\ImageProcessingProject\imgs\Tiger.jpg';

% Get the original image and convert it to a greyscale image
sourceImage = imread(sourceImagePath);
sourceImage = rgb2gray(sourceImage);
figure('Name','Image Before Sharpening','NumberTitle','off'),imshow(sourceImage);

% Run the image sharpning function and compare the results
sharpRate = 5;
sharpImage = imageSharpening(sourceImage,sharpRate);
figure('Name','Image After Sharpening','NumberTitle','off'),imshow(sharpImage);
%}




