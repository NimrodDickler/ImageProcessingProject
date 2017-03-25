[fname pthname]=uigetfile('*.jpg;*.png;*.tif;*bmp','Select the Asset Image'); %select image

I=imread([pthname fname]);

wmsz=1000; %watermark size

I=I(:,:,1);%get the first color in case of RGB image

[r,c]=size(I);

D=dct2(I);%get DCT of the Asset

D_vec=reshape(D,1,r*c);%putting all DCT values in a vector

[D_vec_srt,Idx]=sort(abs(D_vec),'descend');%re-ordering all the absolute values

W=randn(1,wmsz);%generate a Gaussian spread spectrum noise to use as watermark signal

Idx2=Idx(2:wmsz+1);%choosing 1000 biggest values other than the DC value

%finding associated row-column order for vector values

IND=zeros(wmsz,2);

for k=1:wmsz

x=floor(Idx2(k)/r)+1;%associated culomn in the image

y=mod(Idx2(k),r);%associated row in the image

IND(k,1)=y;

IND(k,2)=x;

end

D_w=D;

for k=1:wmsz

%insert the WM signal into the DCT values

D_w(IND(k,1),IND(k,2))=D_w(IND(k,1),IND(k,2))+.1*D_w(IND(k,1),IND(k,2)).*W(k);

end

I2=idct2(D_w);%inverse DCT to produce the watermarked asset

%The extraction process is simply subtracting the original DCT coefficients from the

%watermarked image ones. The code can be written like below:

W2=[];%will contain watermark signal extracted from the image

for k=1:wmsz

    W2=W2(D_w(IND(k,1),IND(k,2))/D(IND(k,1),IND(k,2))-1)*10;%watermark extraction

end