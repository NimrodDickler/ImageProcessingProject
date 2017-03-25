%%%%%%%
% Image Compression Using The Fast Fourier Transform
%%%%%%%
% LIAM FLYNN 2013
%%%%%%%
%% Compression Matricies
%Quantization Matrix
Q=zeros(8,8);
Q(1:8,1)=ones(1,8);
Q(1,1:8)=ones(1,8);
%% Compress Image
% Loop for Cr,Y,Cb
for kk=1:3
I=IMG(:,:,kk); % Isolate specific Cr,Y,Cb
% Compression
MM=double(I)?128; % Transform scale from 0?255 to ?128?127 to apply DCT
CC=zeros(h,w);
QQ=Q;
for i=1:hmax
for j=1:wmax
M=MM(8*i?7:8*i,8*j?7:8*j); % Split into 8x8 pixel blocks
D=fft(M);
C=round(D.*QQ);
CC(8*i?7:8*i,8*j?7:8*j)=C; % Paste 8x8 blocks back together
end
end
% Inverse FFT
for i=1:hmax
for j=1:wmax
CompIMG(8*i?7:8*i,8*j?7:8*j,kk)=ifft(CC(8*i?7:8*i,8*j?7:8*j));
end
end
CompIMG(:,:,kk)=CompIMG(:,:,kk)+128; % Transform scale from ?128?127 to 0?255
end