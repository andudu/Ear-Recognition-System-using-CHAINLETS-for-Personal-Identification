function img=contrasta(img)
x=rgb2ntsc(img);
x(:,:,1)=histeq(x(:,:,1));
c2=ntsc2rgb(x);
%imshow(c2)

% apply histogram equalization to each of the RGB components:
%  and put them all back into a single 3 dimensional array for use with imshow

rimg=histeq(img(:,:,1));
gimg=histeq(img(:,:,2));
bimg=histeq(img(:,:,3));
img=cat(3,rimg,gimg,bimg);
