%% Tiny example
% This is a tiny example that shows how to load two images, extract feature
% from the images and produce a similarity score for the pair
%
% If you would like to write your own script using some of the
% functionality of the toolkit all you would have to do is to generate
% similarity scores for all image pairs we need from you.
%
% Author: Vitomir Struc
% Date: 16.02.2017


%% Start
% You should start in the folder where this file is located 
% Please CD to the location of tiny_example.m


%% Load the images
data_path = '../UERC 2017 Dataset/Test Dataset/0003/';  % change this if you have a different path
data_path1 = '../UERC 2017 Dataset/Test Dataset/0004/';
%load the images
X1=imread([data_path1 '02.png']);
X2=imread([data_path1 '03.png']);

%resize to same size
X1 = imresize(X1,[100,100],'bilinear');
X2 = imresize(X2,[100,100],'bilinear');

%convert to gray-scale
X1 = double(X1); %rgb2gray(X1);
X2 = double(X2);  %rgb2gray(X2);
X11=extrctear(X1);
X11=imdilate(X11,ones(3));
%figure,imshow(X11);
%pause
X22=extrctear(X2);
X22=imdilate(X22,ones(3));
%figure,imshow(X22);
%pause
s1=sum(X11(:))
s2=sum(X22(:))
scmpr=bitor(X11,X22);
%figure,imshow(scmpr);
%pause
sn=sum(scmpr(:))
pause
%% Extract features
% features are extracted by CD-ing to desired folder and calling the uerc_features_extract function

% here is an example for POEM features
cd('../UERC 2017 Toolkit/extractors/uerc_chainlets') %this works for 100x100 images
%f1 = uerc_features_extract(X1);
%f2 = uerc_features_extract(X2);
f1= computeChainletsear((X1));
f2= computeChainletsear((X2));
cd ..
cd ..

c=0;
%% Compare the two feature vectors
d = 1 - f1*f2'/(norm(f1)*norm(f2)); % note that we expect distances (or dissimilarities), hence the 1-cos
disp(sprintf('The cosine distance (or dissimilarity) between the two vectors is: %f.\n',d));
%size(f1(1,:))
%{
for i=0:483
    dd=EditDistance(f1(1,8*i+1:8*i+8),f2(1,8*i+1:8*i+8));
    if dd<=3
        c=c+1;
    end
end
 c   
%}

abs(sum(f1-f2))

distance2 = pdist2(f1, f2, 'correlation')
distance3 = pdist2(f1, f2, 'hamming')
ed=EditDistance(f1,f2);

ed=ed/3872
XI=f1;  XJ=f2;
chii=chi_square_statistics(XI,XJ)
histt=histogram_intersection(XI,XJ)

