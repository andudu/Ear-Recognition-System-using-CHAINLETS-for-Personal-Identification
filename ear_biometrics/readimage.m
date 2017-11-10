function b = readimage(w); 
%Honors Project 2001~2002 
%wuzhili 99050056 
%comp sci HKBU 
%last update 19/April/2002 
 
% read the image w 
% use the full image for further processes 
 
a=imread(w);

a=imresize(a, [100 100]);
b=a;

 