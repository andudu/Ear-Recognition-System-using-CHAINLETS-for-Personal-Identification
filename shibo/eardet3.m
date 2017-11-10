function ee=eardet3(img)


%img=rgb2gray(img);
%img=histeq(img);
%// Your code
%abu=rgb2gray(img);
abu=img;
ee=edge(abu,'canny',.195);
abu=histeq(abu);
abu=double(abu);
cb=imclearborder(abu);
thresh=graythresh(cb);
%b=imbinarize(cb,'adaptive','Sensitivity',.4);
b=im2bw(cb,thresh);

%bw=imfill(b,'holes');
bw=bwareaopen(b,10);

bwfill1=imdilate(bw,ones(4,4));
bwfill1=bwareaopen(bwfill1,300);

%bwfill1=imfill(bwfill1,'holes');
%figure,imshow(bwfill1)
%pause
%// New code starts here
%out = bsxfun(@times, img, uint8(bwfill1));

%// Show the image

[P, nn]=bwlabel(bwfill1,8);
blk=0;
BB=regionprops(P,'Boundingbox','Area','Image','PixelIdxList');
[maxValue,index] = max([BB.Area]);
[rw col]=size(BB);

for i=1:rw
    
    if BB(i).Area==maxValue
       
       
     blk=BB(i).Image;
      
     blk=imresize(blk, [100 100]);
     blk= imdilate(blk,ones(30,30));
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
ee=bwareaopen(ee,21);
