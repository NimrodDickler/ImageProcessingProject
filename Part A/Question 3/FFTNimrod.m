function FFTNimrod(URL)
    
    image = imread(URL); %reads the image into a   
    image=rgb2gray(image); %decreases 1 dimention from a turning it black & white
    image=imresize(image,[201,201]); %resizes a
    furrieredImage=fft2(image); %putting in furrieredImage the 2-D fourier transform
    shiftedFurrieredImage = fftshift(furrieredImage); %swaps the quarters of the matrix
    inversedFurrieredImage=ifft2(furrieredImage); %returns the two-dimensional discrete inverse Fourier transform of the matrix
    subplot(2,2,1); imshow(image,[]); %shows the original image
    imwrite(image,'C:\Matlab\shit for the image project\nimrod1.jpg'); %need to change the path according to the computer
    subplot(2,2,2); imshow((log(furrieredImage)+1),[]) %shows the fouriered image
    subplot(2,2,3); imshow((log(shiftedFurrieredImage)+1),[]); %shows the shifted fourier image
    subplot(2,2,4); imshow(inversedFurrieredImage,[]); %shows the inversed furriered image 
    imwrite(inversedFurrieredImage,'C:\Matlab\shit for the image project\nimrod2.jpg');  %need to change the path according to the computer
end
