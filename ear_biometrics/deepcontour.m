function i211=deepcontour(im,noShow)
i22=dollaredge(im);

i211=bwareaopen(i22,35);
if nargin ==1 
	colormap(gray); 
   imagesc(i211); 
end
