function tsl=rgb2tsl(t) 
%?RGB???TSL???? 
%rgb=im2double(t); 
rgb=imresize(im2double(t),[100 100],'bilinear'); 
r=rgb(:,:,1); 
g=rgb(:,:,2); 
b=rgb(:,:,3); 
T=atan(r./(g+eps))/pi+0.5; 
S=sqrt(9*(r.^2+g.^2)/5); 
L=0.299*r+0.587*g+0;
tsl=cat(3,T,S,L);