function FFTCompression(Path)
    image = imread(Path); %reads the image into a   
    image=rgb2gray(image); %decreases 1 dimention from a turning it black & white
    image=imresize(image,[201,201]); %resizes a
    furrieredImage=fft2(image); %putting in furrieredImage the 2-D fourier transform
    shiftedFurrieredImage = fftshift(furrieredImage); %swaps the quarters of the matrix
    inversedFurrieredImage=ifft2(furrieredImage); %returns the two-dimensional discrete inverse Fourier transform of the matrix
    subplot(2,2,1); imshow(image,[]); %shows the original image
    title('Original');
    subplot(2,2,2); imshow((log(furrieredImage)+1),[]) %shows the fouriered image
    title('Fouriered Image');
    subplot(2,2,3); imshow((log(shiftedFurrieredImage)+1),[]); %shows the shifted fourier image
    title('Shifted Fourier Image');
    subplot(2,2,4); imshow(inversedFurrieredImage,[]); %shows the inversed furriered image
    title('Inversed Furriered Image');
    set(gcf,'numbertitle','off','name','FFTCompression');
end
