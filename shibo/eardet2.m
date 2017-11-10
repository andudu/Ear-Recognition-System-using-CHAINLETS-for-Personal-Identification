I = imread('04.png');  % your original image
i=imresize(I,[100 100]);
ii=histeq(i);
I=i;
figure,imagesc(I)
pause
I=rgb2hsv(I);
I1=I(:,:,2);   % change to hsv and select the channel with most clear contrast between object and shadow

thresholded = I1 > .1; %% Threshold to isolate lungs

figure,imshow(I)
pause
size(thresholded)
thresholded = bwareaopen(thresholded,100);  % remove too small pixels
figure,imshow(thresholded)
pause
I2=thresholded.*I1;
figure,imshow(I2)
pause
I3=edge(I2,'canny',graythresh(I2));  % ostu method
figure,imshow(I3)
pause
ee=I3;
ee1 = bwareaopen(ee,55);
figure,imshow(ee1)
pause

ee(~ee1)=0;
figure,imshow(ee)
pause

close all