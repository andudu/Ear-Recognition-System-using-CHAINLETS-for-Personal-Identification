function [blk1] = drawROI(in,noShow) 
%  drawROI(grayLevelFingerprintImage,ROIboundMap,ROIareaMap,flagToDisableGUI) 
%  construct a ROI rectangle for the input fingerprint image and return the  
%  segmented fingerprint 
%  With the assumption that only one ROI region for each fingerprint image 
%Honors Project 2001~2002 
%wuzhili 99050056 
%comp sci HKBU 
%last update 19/April/2002 
blk=in;

[P, nn]=bwlabel(blk,8);

BB=regionprops(P,'Boundingbox','Area','Image','PixelIdxList');
[maxValue,index] = max([BB.Area]);
[rw col]=size(BB);
for i=1:rw
if BB(i).Area==maxValue
blk=BB(i).Image;
%blk=bwareaopen(blk,200);
blk1= imdilate(blk,ones(3,3));
blk1=imfill(blk1,'holes');
blk1=imresize(blk1, [100 100]);

end
end



blk1=imfill(blk1,'holes');
blk1=bwareaopen(blk1,300);

if nargin ==1 
	colormap(gray); 
   imagesc(blk1); 
end; 
 