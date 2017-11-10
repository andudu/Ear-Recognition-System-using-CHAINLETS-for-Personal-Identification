function ee=extrctear(i2)

%figure,imshow(i2)
%pause
i2=uint8(i);
i2=imsharpen(i2);
i2=imsharpen(i2);
l=graythresh(i2);
bw2=im2bw(i2,l);
%figure,imshow( bw2) ;
%pause
bw2=bwareaopen(bw2,300);
%bw2=imerode(bw2,ones(6,6));
%figure,imshow( bw2) ;
%pause
%bw2=imfill(bw2,'holes');

%l=graythresh(histeq(rgb2gray(i2)));

[P, nn]=bwlabel(bw2,8);
BB=regionprops(P,'Boundingbox','Area','Image','PixelIdxList');
[maxValue,index] = max([BB.Area]);
[rw col]=size(BB);
for i=1:rw
if BB(i).Area==maxValue
%blk=BB(i).Image;
bw2=P==i;
%blk=imresize(blk, [100 100]);
blk=bw2;
end
end

%figure,imshow( bw2) ;
%pause
blk=imdilate(blk,ones(3,3));
blk=imfill(blk,'holes');
%figure,imshow( blk) ;
%pause
[r1 c1]=size(blk);

i2=double(i2);
im(:,:,1)=i2(:,:,1).*blk;
im(:,:,2)=i2(:,:,2).*blk;
im(:,:,3)=i2(:,:,3).*blk;
im=uint8(im);
%figure,imshow(im ) ;
%pause
%i22=dollaredge(im);
%figure,imshow( i22) ;
%pause
i222=edge(rgb2gray(im),'canny');

%figure,imshow( i222) ;
%pause
ee=bwareaopen(i222,16);
%figure,imshow( ee) ;
%pause