function [] = text_extract(steg_im)
%Extract the text info from the stegano bmp image;
%steg_im:the file name or path of the stegano image,should end with '.bmp';
bmp = imread(steg_im);
place = 1;
len = zeros(1,7);
%extract the length of the string.
for i = 1:7
    len(i) = bitget(bmp(i),place);
end
len = bi2de(len);
%use the length initialize the message matrix.
message = zeros(7,len);
%extract the message
for j = 1:7*len
    message(j) = bitget(bmp(j+7),place);
end
msgasc = bi2de(message');
message = char(msgasc);message = message';
%print the secret message
fprintf('The secret info is :%s\n',message);
imshow(bmp);title(message);
end