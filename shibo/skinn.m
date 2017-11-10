
function I1=skinn(I1)
[r,c,~]=size(I1);
I=I1(round(r/1.3):end,:,:);

%I=imread('01.png');

%I=imresize(I,[100 100]);
I=double(I);
I1=double(I1);
%ee1=edge(gry,'canny',.3);
[hue,s,v]=rgb2hsv(I);

cb =  0.148* I(:,:,1) - 0.291* I(:,:,2) + 0.439 * I(:,:,3) + 128;
cr =  0.439 * I(:,:,1) - 0.368 * I(:,:,2) -0.071 * I(:,:,3) + 128;
[w h]=size(I(:,:,1));
for i=1:w
    for j=1:h            
        if  140<=cr(i,j) && cr(i,j)<=165 && 140<=cb(i,j) && cb(i,j)<=195 && 0.01<=hue(i,j) && hue(i,j)<=0.1     
            segment(i,j)=1;  
           
        else
            
            segment(i,j)=0; 
            
        end
        %{
        ff=find(segment==0);
        size(ff)
        pause
        %}
    end
end
 
i1=I1(round(r/1.3):end,:,1).*segment;   
i2=I1(round(r/1.3):end,:,2).*segment; 
i3=I1(round(r/1.3):end,:,3).*segment; 
ii=cat(3,i1,i2,i3);
ii=uint8(ii);
I1=uint8(I1);
I1(round(r/1.3):end,:,:)=ii;

if nargin ==1 
	colormap(gray); 
   imagesc(I1); 
end; 

%{
L=graythresh(J);
BW1=im2bw(J,L);
%figure,imshow(BW1)
%pause
%BW1=imfill(BW1,'holes');
%BW1=bwareaopen(BW1,300);
BW1=imerode(BW1,ones(3,3));
BW1=bwareaopen(BW1,300);
%figure,imshow(BW1)
%pause


[rr,cc]=find(BW1(end-3:end,:)==0);

BW1((100-max(rr)):end,:)=0;
BW1=imfill(BW1,'holes');
BW1=imdilate(BW1,ones(2,2));

BW1=imfill(BW1,'holes');

cc=find(BW1==0);
c2=find(BW1==1);
if length(cc)>2*length(c2) || size(I,3)==1
  disp 'kk'
    ee=bwareaopen(ee1,30);
    %ee=dollaredge(uint8(I));
else
  disp 'llll'  
  ee=connbw(BW1,ee1);
  ee=bwareaopen(ee,20);
end
%}