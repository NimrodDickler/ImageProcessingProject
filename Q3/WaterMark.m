clear all
close all


%reads the image in double format
imageAfterDouble = double(imread('Tiger.jpg'));
figure,imshow(imageAfterDouble/255);
secondCopyOfImage = imageAfterDouble;
[rows,cols] = size(secondCopyOfImage);

%creating the mark
a = zeros(80,150); %defining the black frame
a(2:15,4:40) = 1; %defining the white reqtangle
figure,imshow(a);
save m.dat a -ascii %saves the mark

%water marking
x1 = imageAfterDouble(:,:,1);
x2 = imageAfterDouble(:,:,2);
x3 = imageAfterDouble(:,:,3);
dx1 = dct2(x1); dx11 = dx1;
dx2 = dct2(x2); dx22 = dx2;
dx3 = dct2(x3); dx33 = dx3;
load m.dat
g = 10; %binary mask for water marking
[rm,cm] = size(m);
dx1(1:rm,1:cm) = dx1(1:rm,1:cm) + g * m;
dx2(1:rm,1:cm) = dx2(1:rm,1:cm) + g * m;
dx3(1:rm,1:cm) = dx3(1:rm,1:cm) + g * m;
figure,imshow(dx1);
figure,imshow(dx2);
figure,imshow(dx3);
y1 = idct2(dx1);
y2 = idct2(dx2);
y3 = idct2(dx3);
secondCopyOfImage(:,:,1) = y1;
secondCopyOfImage(:,:,2) = y2;
secondCopyOfImage(:,:,3) = y3;
figure,imshow(y1);
figure,imshow(y2);
figure,imshow(y3);
figure,imshow(secondCopyOfImage);
figure; imshow(secondCopyOfImage/255);
figure; imshow(abs(secondCopyOfImage-imageAfterDouble)*100); %comparison


z = secondCopyOfImage;
[r,c,s] = size(z);


%De-water marking
%clean image (known mask)
secondCopyOfImage = z;
dy1 = dct2(secondCopyOfImage(:,:,1));
dy2 = dct2(secondCopyOfImage(:,:,2));
dy3 = dct2(secondCopyOfImage(:,:,3));
dy1(1:rm,1:cm) = dy1(1:rm,1:cm) - g * m;
dy2(1:rm,1:cm) = dy2(1:rm,1:cm) - g * m;
dy3(1:rm,1:cm) = dy3(1:rm,1:cm) - g * m;
y11 = idct2(dy1);
y22 = idct2(dy2);
y33 = idct2(dy3);
yy(:,:,1) = y11;
yy(:,:,2) = y22;
yy(:,:,3) = y33;
figure; imshow(yy/255)
figure; imshow(abs(yy-imageAfterDouble)*10000) %comparison showing all black image for no difference between yy and x




















