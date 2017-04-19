function WaterMark(URL)




%reads the image in double format
imageAfterDouble = double(imread(URL));
figure,imshow(imageAfterDouble/255);
secondCopyOfImage = imageAfterDouble;
[rows,cols] = size(secondCopyOfImage);

%creating the mark
a = zeros(80,150); %defining the black frame
a(2:15,4:40) = 1; %defining the white reqtangle
figure,imshow(a);
save m.dat a -ascii %saves the mark

%water marking
x1 = imageAfterDouble(:,:,1);%defining the RGB compoments
x2 = imageAfterDouble(:,:,2);%defining the RGB compoments
x3 = imageAfterDouble(:,:,3);%defining the RGB compoments
dx1 = dct2(x1); dx11 = dx1;%returning the 2-D cosine transfom for each of the RGB
dx2 = dct2(x2); dx22 = dx2;%returning the 2-D cosine transfom for each of the RGB
dx3 = dct2(x3); dx33 = dx3;%returning the 2-D cosine transfom for each of the RGB
load m.dat %binary mask for water marking
g = 10; %water mark coefficient- the bigger it is the more visible the mark will become
[rm,cm] = size(m);%putting the size of m into rows and columns
dx1(1:rm,1:cm) = dx1(1:rm,1:cm) + g * m; %adding the new data of g and m into the red
dx2(1:rm,1:cm) = dx2(1:rm,1:cm) + g * m; %adding the new data of g and m into the green
dx3(1:rm,1:cm) = dx3(1:rm,1:cm) + g * m; %adding the new data of g and m into the blue
figure,imshow(dx1); %showing the new red
figure,imshow(dx2); %showing the new green
figure,imshow(dx3); %showing the new blue

%performing the inverse
y1 = idct2(dx1); %putting the 2-D cosine transform of red in y1
y2 = idct2(dx2); %putting the 2-D cosine transform of green in y2
y3 = idct2(dx3); %putting the 2-D cosine transform of blue in y3
secondCopyOfImage(:,:,1) = y1; %defining the copy's red to be y1
secondCopyOfImage(:,:,2) = y2; %defining the copy's green to be y2
secondCopyOfImage(:,:,3) = y3; %defining the copy's blue to be y3
figure,imshow(y1); %showing y1
figure,imshow(y2); %showing y2
figure,imshow(y3); %showing y3
figure,imshow(secondCopyOfImage); %shows the copy after new defenitions
figure; imshow(secondCopyOfImage/255); %after Division shows the real image with the water mark
figure; imshow(abs(secondCopyOfImage-imageAfterDouble)*100); %shows the difference between the image with the water mark
%to the image without it


z = secondCopyOfImage;
[r,c,s] = size(z); %putting the dize of the water marked  image into r,c and s

%removing the water mark
%clean image (known mask)
secondCopyOfImage = z;
dy1 = dct2(secondCopyOfImage(:,:,1)); %putting the 2-D cisone transform of the water marked image's red into dy1
dy2 = dct2(secondCopyOfImage(:,:,2)); %putting the 2-D cisone transform of the water marked image's green into dy2
dy3 = dct2(secondCopyOfImage(:,:,3)); %putting the 2-D cisone transform of the water marked image's blue into dy3
dy1(1:rm,1:cm) = dy1(1:rm,1:cm) - g * m; %reducing the new data of g and m from the red
dy2(1:rm,1:cm) = dy2(1:rm,1:cm) - g * m; %reducing the new data of g and m from the green
dy3(1:rm,1:cm) = dy3(1:rm,1:cm) - g * m; %reducing the new data of g and m from the blue
y11 = idct2(dy1); %putting dy1's 2-D cosine transform into y11
y22 = idct2(dy2); %putting dy2's 2-D cosine transform into y22
y33 = idct2(dy3); %putting dy3's 2-D cosine transform into y33
yy(:,:,1) = y11; %yy's red initializes with y11
yy(:,:,2) = y22; %yy's green initializes with y22 
yy(:,:,3) = y33; %yy's blue initializes with y33
figure; imshow(yy/255) %shows the image without the water mark
figure; imshow(abs(yy-imageAfterDouble)*10000) %comparison showing all black image for no difference between yy and x




















