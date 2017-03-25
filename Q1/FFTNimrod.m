function FFTNimrod(URL)
    a=imread(URL);
    a=rgb2gray(a);
    a=imresize(a,[201,201]);
    F=fft2(a);
    Fs = fftshift(F);
    b=ifft2(F);
    subplot(2,2,1); imshow(a,[]);
    imwrite(a,'d:\nimrod1.jpg');
    subplot(2,2,2); imshow((log(F)+1),[])
    subplot(2,2,3); imshow((log(Fs)+1),[]);
    subplot(2,2,4); imshow(b,[]);
    imwrite(b,'d:\nimrod2.jpg');
end
%{
ImageFi
fileinfo = dir(ImageFileName); 
filesize = fileinfo(1).size;
figure('Name','Image After Sharpening','NumberTitle','off'),imshow(sharpImage);
%}