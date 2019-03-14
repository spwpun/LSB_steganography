function [] = text_hide(image_name, message)
%Using LSB algorithm to hide the message in a image file;
%image_name:the name of bmp image, the extension of the file name should be
%.bmp;
%message:the information you want to hide.

carry_im = imread(image_name);
steg_im = carry_im;
place = 1;
len = length(message);  %The length of message.
msgasc = double(message);
msgstr = de2bi(msgasc,7,2); %Transfer the message to binary str,one dimension;
msgstr = msgstr';
lenstr = de2bi(len,7,2);
%store the length as the first 7 bits
for i = 1:7
    steg_im(i) = bitset(carry_im(i),place,lenstr(i));
end
%store the message as the rest.
for j = 1:len*7 %7 bits for a character.
    steg_im(j+7) = bitset(carry_im(j+7),place,msgstr(j));
end
imshow(steg_im);title('Stegano Image');
imwrite(steg_im,'Stegano_text.bmp');
end
