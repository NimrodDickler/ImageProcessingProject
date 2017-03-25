function [sharpImage] = imageSharpening(image,sharpRate)

    %Build The Matrix
    A = ([1 1 1; 1 1 1; 1 1 1])/9;
    
    %Return the central convolution
    Smooth = conv2(image,double(A), 'same');
    
    %Return the detailed image (according to the furmula)
    Detail = uint8(image) - uint8(Smooth);
    
    %according to the formula as well (sharpened = original +(scalar*detailed))
    sharpImage = image + (sharpRate * Detail);
end

