%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Processing - Final Project
% Part A: Single image processing
% Question 1: Histogram Equalization Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Define paths for files
sourceImagePath = '.\imgs\Mountains_Greyscale.jpg';
destImagePath = '.\imgs\Mountains_GreyscaleHE.jpg';
destHistogramPath = '.\imgs\Mountains_GreyscaleHE_Histogram.jpg';
showMatlabHistEQ = 0;
% Get the original image and convert it to a greyscale image if needed
sourceImage = imread(sourceImagePath);
if size(sourceImage,3)==3
    sourceImage = rgb2gray(sourceImage);
end

% display the source image and the histogram for that image
sourceImageHistogram = CreateHistogram(sourceImage);
figure('Name','Source Image Histogram - Before Histogram Equalization','NumberTitle','on'),bar(sourceImageHistogram);
figure('Name','Source Image - Before Histogram Equalization','NumberTitle','on'),imshow(sourceImage);

%calling our histogram equalization function
[HEImage,destImageHistogram]= HistogramEqualizationFunction(sourceImage);

hold on
%display the image after the histogram equalization function and the histogram for the image
figure('Name','Dest Image - After Histogram Equalization','NumberTitle','on'),imshow(HEImage);
figure('Name','Dest Image Histogram - After Histogram Equalization','NumberTitle','on'),bar(destImageHistogram);
imwrite(HEImage,destImagePath);


%%%%%%%%%%%%%%%%
%MatLab Histeq %
%%%%%%%%%%%%%%%%
if showMatlabHistEQ == 1
    %Compare the the histeq function built in to matlab
    MLHEImage = histeq(sourceImage);

    %display the image after the built in matlab histogram equalization and the histogram for
    %that image
    figure('Name','After MatLab Histogram Equalization','NumberTitle','off'),imshow(MLHEImage);
    MLHEImageHistogram = CreateHistogram(MLHEImage);
    figure('Name','After MatLab Histogram','NumberTitle','off'),bar(MLHEImageHistogram);
end

