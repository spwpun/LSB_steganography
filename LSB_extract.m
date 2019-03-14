function outim = LSB_extract(stegno_im)
%Extract the secret image
%stegno:the name and path of the stegano iamge;

steg_bmp = imread(stegno_im);
place = 1;
height = zeros(1,10);
width = zeros(1,10);
%extract the height of secret image;
for i = 1:10
    height(i) = bitget(steg_bmp(i),place);
end
%extract the width of secret image;
for j = 11:20
    width(j-10) = bitget(steg_bmp(j),place);
end
%Transfer to decimal.
height = bi2de(height);
width = bi2de(width);

outim = ones(height,width);
%extract the image info.
for i = 1:height*width
    outim(i) = bitget(steg_bmp(i+20),place);
end
figure;imshow(outim);title('secret image');
imwrite(outim,'SECRET.bmp');
end