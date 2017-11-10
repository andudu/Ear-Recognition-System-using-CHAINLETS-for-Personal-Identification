function ee=connbw(BW1,ee)
[P, nn]=bwlabel(BW1,8);
blk=0;
BB=regionprops(P,'Boundingbox','Area','Image','PixelIdxList');
[maxValue,index] = max([BB.Area]);
[rw col]=size(BB);

for i=1:rw
    
    if BB(i).Area==maxValue
       
       
     blk=BB(i).Image;
    
     blk=imresize(blk, [100 100]);
     blk= imdilate(blk,ones(4,4));
     blk=imfill(blk,'holes');

    end
    
end
%figure,imshow(blk)
%pause
[ro1 ,co1]=size(blk);
for i=1:ro1
    for j=1:co1
        if(blk(i,j)~=1)
           ee(i,j)=0;
        end
    end
end
ee=bwareaopen(ee,15);