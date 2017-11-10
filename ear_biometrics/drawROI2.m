function [im] = drawROI2(blk,in,noShow) 
%  drawROI(grayLevelFingerprintImage,ROIboundMap,ROIareaMap,flagToDisableGUI) 
%  construct a ROI rectangle for the input fingerprint image and return the  
%  segmented fingerprint 
%  With the assumption that only one ROI region for each fingerprint image 
%Honors Project 2001~2002 
%wuzhili 99050056 
%comp sci HKBU 
%last update 19/April/2002 
i2=in;

i2=double(i2);
im(:,:,1)=i2(:,:,1).*blk;
im(:,:,2)=i2(:,:,2).*blk;
im(:,:,3)=i2(:,:,3).*blk;
im=uint8(im);

if nargin ==2 
	colormap(gray); 
   imagesc(im); 
end; 
 