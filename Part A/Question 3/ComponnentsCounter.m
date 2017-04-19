%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Processing - Final Project
% Part A: Single image processing
% Question 2: Finding connected components in a binary image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Define paths for files
sourceImagePath = '.\imgs\binary_crosses.jpg';
threshold = 0.1;

% Get the original image
sourceImage = imread(sourceImagePath);

% Call our componnentCounterunction
figure('Name','Image','NumberTitle','off'),imshow(sourceImage);
ComponnentsCounterFunction(sourceImage,threshold);

