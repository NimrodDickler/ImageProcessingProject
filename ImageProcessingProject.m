%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Processing Final Project Questions
% 
%
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Question 1 Histogram Equalization

%Define paths for files
workingDirectory = 'D:\Git\Private\ImageProcessingProject';
sourceImagePath = 'D:\Git\Private\ImageProcessingProject\Mountains_Greyscale.jpg';
sourceHistogramPath = 'D:\Git\Private\ImageProcessingProject\Mountains_Greyscale_Histogram.jpg';
destImagePath = 'D:\Git\Private\ImageProcessingProject\Mountains_GreyscaleHE.jpg';
destHistogramPath = 'D:\Git\Private\ImageProcessingProject\Mountains_GreyscaleHE_Histogram.jpg';

% Get the original image and convert it to a greyscale image
sourceImage = imread(sourceImagePath);
sourceImage = rgb2gray(sourceImage);

%display the source image and the histogram for that image and save results
figure('Name','Source Image - Before Histogram Equalization','NumberTitle','off'),imshow(sourceImage);
sourceImageHistogram = CreateHistogram(sourceImage);
figure('Name','Source Image - Before Histogram Equalization','NumberTitle','off'),bar(sourceImageHistogram);
imwrite(sourceImageHistogram,sourceHistogramPath);

%calling our histogram equalization function 
HEImage,destImageHistogram= HistogramEqualizationFunction(sourceImage);

%display the image after the histogram equalization and the histogram for
%that image and save results
figure('Name','Dest Image - After Histogram Equalization','NumberTitle','off'),imshow(HEImage);
figure('Name','Dest Image Histogram - After Histogram Equalization','NumberTitle','off'),bar(destImageHistogram);
imwrite(destImageHistogram,destHistogramPath);

%Compare the the histeq function built in to matlab
MLHEImage = histeq(uint8(sourceImage));

%display the image after the built in matlab histogram equalization and the histogram for
%that image
figure('Name','After MatLab Histogram Equalization','NumberTitle','off'),imshow(MLHEImage);

%Display the histogram of the matlab equalization
MLHEImageHistogram = CreateHistogram(MLHEImage);
figure('Name','After MatLab Histogram','NumberTitle','off'),bar(MLHEImageHistogram);




