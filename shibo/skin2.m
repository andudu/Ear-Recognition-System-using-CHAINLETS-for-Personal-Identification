function ee=skin2(I)
close all;
clc
%I=imread(I);
%I=imresize(I,[100 100]);


gry=rgb2gray(I);
gry=histeq(gry);
%ed=eardet3(gry);

ee=edge(gry,'canny',.18);
ee=bwareaopen(ee,20);
cform = makecform('srgb2lab');
J = applycform(I,cform);

L=graythresh(J(:,:,2))
BW1=im2bw(J(:,:,2),L);
BW1=imfill(BW1,'holes');
BW1=imdilate(BW1,ones(2,2));

imshow(BW1)

pause
[r1 c1]=size(BW1);
for i=1:r1
    for j=1:c1
        if(BW1(i,j)~=1)
           ee(i,j)=0;
        end
    end
end
ee=bwareaopen(ee,10);
imshow(ee)
pause
