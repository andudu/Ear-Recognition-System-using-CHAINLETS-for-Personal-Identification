function ee=ear_det(I)
i=rgb2gray(I);
i=histeq(i);
imshow(i)
pause
i=uint8(i);
imshow(i)
pause
cform = makecform('srgb2lab');
J = applycform(I,cform);

K=J(:,:,2);

L=graythresh(J(:,:,2));
BW1=im2bw(J(:,:,2),L);

M=graythresh(J(:,:,3));

BW2=im2bw(J(:,:,3),M);


O=BW1.*BW2;
O= imdilate(O,ones(6,6));



% Bounding box
ee=edge(rgb2gray(I),'canny',.15);
[r,c]=size(ee)
blk=zeros(r,c);
blk1=zeros(r,c);

[P, nn]=bwlabel(O,8);
nn
BB=regionprops(P,'Boundingbox','Area','Image','PixelIdxList');
[maxValue,index] = max([BB.Area]);
[rw col]=size(BB);

for i=1:rw
    
    if BB(i).Area==maxValue
       
       
     blk=BB(i).Image;
      
     blk=imresize(blk, [100 100]);
     blk= imdilate(blk,ones(3,3));
     blk=imfill(blk,'holes');

     
     
    end
    
end
[r1 c1]=size(blk);
for i=1:r1
    for j=1:c1
        if(blk(i,j)~=1)
           ee(i,j)=0;
        end
    end
end
ee=bwareaopen(ee,30);
