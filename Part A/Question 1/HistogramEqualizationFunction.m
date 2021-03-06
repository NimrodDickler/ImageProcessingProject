%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Image Processing Final Project - Question 1 Histogram Equalization
% This fuction will get he source image(B&W)
%
% In the end the fuction will return the image after Histogram Equalization
% and the histogram
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [HEImage,HEImageHistogram] = HistogramEqualizationFunction(sourceImage)
    
    %Get the number of rows&colunms in the image matrix (for iteration) and the total number of pixels 
    rows = size(sourceImage,1);
    columns = size (sourceImage,2);
    totalPixels = rows * columns;
    
    %Create a frequency array full of zeros (0-255 gret levels)
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
    
    %Calculate the probability distribution function
    %(the precentage of a grey level pixel in the picture (between 0-1))  
    for i=1:256
        pdf(i)=frequency(i)/totalPixels;
    end
    
    %Create a cummulative probability distribution function array full of zeros
    cdf=(zeros(256,1));
    
    %Calculate the cummulative probability distribution function
    cdf(1) = pdf(1);
    for i=2:256
        %adding the pdf value to the cfd array
        cdf(i)= cdf(i-1)+ pdf(i);
    end
    
    %Create an output array full of zeros
    output = (zeros(256,1));
    
    %create an output array with a more "balanced" grey levels
    for i=1:256
        output(i) = round(cdf(i)*255); 
    end
    
    %initialize array for the new image
    HEImage=uint8(zeros(rows,columns));
    
    %apply the output array on the original image to create a histogram
    %equalized image (balance the image intensities)
    for i=1:rows
        for j=1:columns
			HEImage(i,j)=output(sourceImage(i,j)+1);
        end
    end
    
    %create a histogram of the new image
    HEImageHistogram = CreateHistogram(HEImage);    
end




