clc;
clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Img = imread('GAD.png');
Img=rgb2gray(Img);
[row,column]=size(Img);
row_a=row;
column_a=column;
if mod(row,8)~=0  
    row_a=row+(8-mod(row,8));
end     
if mod(column,8)~=0
    column_a=column+(8-mod(column,8));
end
image =zeros(row_a,column_a);
image(1:row,1:column) = Img(1:row,1:column);
compressed=zeros(row_a,column_a);
outout=zeros(row_a,column_a);
N=8;
imwrite(image/255,'D:\before_compression.jpg');
figure; imshow(image/255);

%%%%%%%%%% taking factor r and multiply by the QMat %%%%%%%%%%%%%%%%%
n= input('Enter number of images you want to generate ')
for i=0:1:n
%%%%%%%%%%%%%%%% assigning quantiazation matrix %%%%%%%%%%%%%%%%%%%%%%%
Q =[16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56 ;
    14 17 22 29 51 87 80 62 ;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 194 113 92;
    49 64 78 87 103 121 120 101; 
    72 92 95 98 121 100 103 99];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r= input('r = ' )
Q=Q*r;
for i=1:N:row_a
    for j=1:N:column_a
        image_block=image(i:i+N-1,j:j+N-1);
        df=dct2(image_block);
        compressed_block=round(df./Q);
        compressed(i:i+N-1,j:j+N-1)=compressed_block;
    end 
end  
%figure; imshow(compressed);
for i=1:N:row_a
    for j=1:N:column_a
        inverse_block=compressed(i:i+N-1,j:j+N-1);
        inverse_block=inverse_block.*Q;
        inverse_block=idct2(inverse_block);
        output(i:i+N-1,j:j+N-1)=inverse_block;
    end 
end  
output=uint8(output);
figure;imshow(output);

imwrite(output,'D:\after_compression.jpg');
end