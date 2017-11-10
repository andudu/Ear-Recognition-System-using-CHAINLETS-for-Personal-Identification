function [o] = adaptiveThres(a,noShow); 
%Adaptive thresholding is performed by segmenting image a 
%Honors Project 2001~2002 
%wuzhili 99050056 
%comp sci HKBU 
%last update 19/April/2002 

l=graythresh(a);
bw2=im2bw(a,l);
bw2=bwareaopen(bw2,300);
%figure,imshow(bw2)
%pause
%bw22=imfill(bw2,'holes');
%bw22=imdilate(bw2,ones(2,2));
blk=bw2;
%figure,imshow(blk)
%pause


o= blk;
if nargin == 1 
imagesc(o); 
colormap(gray); 
end; 