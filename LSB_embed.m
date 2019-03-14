function [] = LSB_embed(cover_im,secret_im)
%Use the LSB algorithm to hide the secret_image in the cover_image;
%cover_im:the name of the cover_image;
%secret_im:the name of the secret_image;

%Read the image and convert the cover_image to grayscale_image, convert the
%secret_iamge the binary_image;
rgb_cover = imread(cover_im);
rgb_sec = imread(secret_im);
gray_cover = rgb2gray(rgb_cover);
bin_secret = im2bw(rgb_sec);
place = 1;    %The custom Least Significant Bit;

[row,col] = size(gray_cover);
[row2,col2] = size(bin_secret);
info_height = de2bi(row2,10,2,'right-msb'); %The max height is 2^10 = 1024 pixels;
info_width = de2bi(col2,10,2,'right-msb');  %The same as above!
size_info = [info_height,info_width];

outim = gray_cover;
if(row2*col2>(row*col-20))  %The former 20 bits store the size of secret image!
    sprintf('You should choose another more smaller image!');
    warning('Too large,the information maybe part disappear!');
else
    %store the size info of secret iamge in the former 20 bits;
    for i = 1:20
        outim(i) = bitset(gray_cover(i),place,size_info(i));
    end
    %store the image info in the rest of cover;
    for j=1:row2*col2
        index = j+20;
        outim(index) = bitset(gray_cover(index),place,bin_secret(j));
    end
end
imshow(outim);
title('stegano image');
imwrite(outim,'STEGANO_IMAGE.bmp');
end