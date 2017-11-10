i=imread('04.png');
i=imresize(i,[100 100]);
ii=histeq(i);
figure,imshow(ii)
pause

eq =imdilate(ii,ones(1,2));
ee=edge(rgb2gray(eq),'canny',.2);
figure,imshow(ee)
pause

ee1 = bwareaopen(ee,55);

figure,imshow(ee1)
pause

ee(~ee1)=0;
figure,imshow(ee)
pause
close all