function [feature] = computeChainletsear(im)
%im=eardet3(im);
%im=skin(im);
im=extrctear(im);

figure,imshow(im)
pause
%%%im=uint8(im);
%im=edge(im,'canny',.15);

%im=compute_edges3(im);
%{
if c<64 && r<128
    disp 'newww'
  im1=zeros(128,64);
  
  r1=round(64-r/2);
  c1=round(32-c/2);
  im1(r1:r1+r-1,c1:c1+c-1)=im;
  
  im=im1; 
else
    
    im=imresize(im, [128 64]);
   
end
%}
n_bins=8;
rows=size(im,1);
cols=size(im,2);
magnitude=im;
% figure,imshow(uint8(angle));
% figure,imshow(uint8(magnitude));

% Remove redundant pixels in an image. 

magnitude(isnan(magnitude))=0;

feature=[]; %initialized the feature vector

% Iterations for Blocks
for i = 0: rows/8 -2
    for j= 0: cols/8 -2
        %disp([i,j])

        mag_patch = magnitude(8*i+1 : 8*i+16 , 8*j+1 : 8*j+16);
       
        block_feature=[];
        
        %Iterations for cells in a block
        for x= 0:1
            for y= 0:1
           
                magA   =mag_patch(8*x+1:8*x+8, 8*y+1:8*y+8); 
                
                histr  =zeros(1,n_bins);
                
                n=bwconncomp(magA,8);
                 num = n.NumObjects; 
                     %bbox1=imcrop(magA,n1(m).BoundingBox);
                 if num>0
                     s = regionprops(n, magA,'PixelValues','EulerNumber');
                     l1=length(s);
                     if (s(l1).EulerNumber ~= 1)
                        l=true;

                     else
                        l=false;
                     end
                 b1=boundaries(magA);
                 
                 h=computehistt(b1,l);
                 ll=length(h);
                 histr=hist(h, 0:7);
                 histr=sort(histr);
                 %histr=histr/ll;
                 
                 end 

                %Iterations for pixels in one cell
                
                block_feature=[block_feature histr]; % Concatenation of Four histograms to form one block feature
                               
            end
            
        end
       
% Normalize the values in the block using L1-Norm
        %block_feature=block_feature/sqrt(norm(block_feature)^2+.01);
               
        feature=[feature block_feature]; %Features concatenation
    end
end

feature(isnan(feature))=0; %Removing Infinitiy values
%feature=feature/sqrt(norm(feature)^2+.001);
% Normalization of the feature vector using L2-Norm
%{
feature=feature/sqrt(norm(feature)^2+.001);
for z=1:length(feature)
    if feature(z)>0.2
         feature(z)=0.2;
    end
end
feature=feature/sqrt(norm(feature)^2+.001); 
%}
end
function h=computehistt(b1,l)
h=[];
  for i=1:length(b1)
   [r,c]=size(b1{i});
     if r>2
       c=fchcode(b1{i},8,l);
       r=Rltvchain4(c.fcc,l);
       %r=sort(r);
       h=[h r];
      
     end
   end

end