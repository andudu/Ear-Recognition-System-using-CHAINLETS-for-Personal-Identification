function i=earprepros(i,t)
i=imread(i);
i=rgb2gray(i);
i=imresize(i,[100 100]);
i=histeq(i);
i=double(i);
%im=edge(i,'canny',t);
%figure,imshow(im)