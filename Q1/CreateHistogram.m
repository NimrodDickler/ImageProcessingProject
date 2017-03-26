%Create histogram for a greyscale image
function [imageHist] = CreateHistogram(image)

    %Reshape the image to a sinlge dimension array
    imageHistData=reshape(image,[],1);
    
    %convert the array to double-precision values 
    imageHistData=double(imageHistData);
    
    %create the histogram
    imageHist=hist(imageHistData,0:255);
    imshow(imageHist);
end
