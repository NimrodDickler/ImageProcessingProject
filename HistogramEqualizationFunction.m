%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Image Processing Final Project - Question 1 Histogram Equalization
% This fuction will get a peth to the source image(B&W)
%
% In the end the fuction will save the file to the destination path and
% return the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [HEImage] = HistogramEqualizationFunction(sourceImagePath)
    sourceImage = imread(sourceImagePath);
    
    %Get the number of rows&colunms in the image matrix for iteration and the total number of pixels 
    rows = size(sourceImage,1);
    columns = size (sourceImage,2);
    totalPixels = rows * columns;
    
    %Create a frequency array full of zeros
    frequency = (zeros(256,1));
    
    %Iterate throught every pixel in the image add calculate the grey level
    %frequency array
    for i=1:rows
        for j=1:columns
            %curPixel will sotre the level of grey (0-255) of the pixel
            curPixel=sourceImage(i,j);
            
            %we save the amount of pixels in the same grey level to the frequency array 
            %we add 1 to the value because our array is between 1-256
            frequency(curPixel+1)=frequency(curPixel+1)+1;
        end
    end
    
    %Create a probability distribution function array full of zeros
    pdf=(zeros(256,1));
    
    %Calculate the Probability Distribution Function
    %(the precentage of a grey level pixel in the picture (between 0-1)  
    for i=1:256
        pdf(i)=frequency(i)/totalPixels;
    end
    
    for i=1:256
        frequency
    end
    
    
    
   
    cummulativeDistributionFunction=(zeros(256,1));
    cummulative = (zeros(256,1));
    output = (zeros(256,1));
    
    
    
    
    
    

    
    
        
    HEImage =  sourceImage;
end


