function FFTNimrod(URL)
    a=imread(URL);
    a=rgb2gray(a);
    a=imresize(a,[201,201]);
    F=fft2(a);
    Fs = fftshift(F);
    b=ifft2(F);
    subplot(2,2,1); imshow(a,[]);
    subplot(2,2,2); imshow((log(F)+1),[])
    subplot(2,2,3); imshow((log(Fs)+1),[]);
    subplot(2,2,4); imshow(b,[]);
end