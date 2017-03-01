%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Processing Final Project Questions
% 
%
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Question 1 Histogram Equalization
workingDirectory = 'H:\Downloads\Image Processing\';
sourceImagePath = 'H:\Downloads\Image Processing\Mountains_Greyscale.jpg';
destImagePath = 'H:\Downloads\Image Processing\Mountains_GreyscaleHE.jpg';

%calling the function 
HEImage = HistogramEqualizationFunction(sourceImagePath);

%compare the original image and compare the results
figure('Name','Before Histogram Equalization','NumberTitle','off'),imshow(sourceImagePath);
figure('Name','After Histogram Equalization','NumberTitle','off'),imshow(HEImage);

%save the results
imwrite(HEImage,destImagePath);
